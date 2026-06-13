#!/usr/bin/env bash
set -euo pipefail

# Формирует Mikrotik address-list .rsc файлы (IPv4 + IPv6) и плоские текстовые
# списки адресов для ASN, перечисленных в asn-lists.json.
#
# Анонсируемые префиксы берутся "вживую" из RIPEstat. Скрипт рассчитан на
# запуск внутри GitHub Actions после того, как geoip уже сгенерировал ./output.
#
# Формат asn-lists.json: { "<имя_файла>": [ASN, ASN, ...], ... }
# Имя используется только для имён выходных файлов; в самих .rsc все адреса
# попадают в общий address-list (LIST_NAME) с общим comment (COMMENT) — так же,
# как в шаге "Generate .rsc from all lists".
#
# Использование: scripts/gen-asn-lists.sh [config] [output_dir] [list_name] [comment]

CONFIG="${1:-asn-lists.json}"
OUT_DIR="${2:-./output}"

# Общий address-list и comment — как в шаге "Generate .rsc from all lists".
LIST_NAME="${3:-to_vpn}"
COMMENT="${4:-rbgeoip}"

MIKROTIK_DIR="${OUT_DIR}/mikrotik"
TEXT_DIR="${OUT_DIR}/asn"

mkdir -p "$MIKROTIK_DIR" "$TEXT_DIR"

generated_at="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"

# Перебираем все имена списков, объявленные в конфиге.
for name in $(jq -r 'keys[]' "$CONFIG"); do
  echo "==> Building ASN list '${name}'"

  v4_prefixes=""
  v6_prefixes=""

  # Собираем анонсируемые префиксы для каждого ASN этого списка.
  for asn in $(jq -r --arg n "$name" '.[$n][]' "$CONFIG"); do
    echo "    fetching AS${asn} from RIPEstat"
    resp="$(curl -fsSL --retry 3 --retry-delay 5 \
      "https://stat.ripe.net/data/announced-prefixes/data.json?resource=AS${asn}")"

    prefixes="$(echo "$resp" | jq -r '.data.prefixes[].prefix')"
    if [[ -z "$prefixes" ]]; then
      echo "    !! no prefixes returned for AS${asn}" >&2
      exit 1
    fi

    while IFS= read -r p; do
      [[ -z "$p" ]] && continue
      if [[ "$p" == *:* ]]; then
        v6_prefixes+="${p}|${asn}"$'\n'
      else
        v4_prefixes+="${p}|${asn}"$'\n'
      fi
    done <<< "$prefixes"
  done

  # Убираем дубли, сохраняя метку ASN.
  v4_prefixes="$(printf '%s' "$v4_prefixes" | sort -u)"
  v6_prefixes="$(printf '%s' "$v6_prefixes" | sort -u)"

  # --- Mikrotik IPv4 .rsc ---
  v4_rsc="${MIKROTIK_DIR}/${name}.rsc"
  {
    echo "# Generated: ${generated_at}"
    echo "# Source : RIPEstat announced-prefixes (${name})"
    echo ""
  } > "$v4_rsc"
  while IFS='|' read -r prefix asn; do
    [[ -z "$prefix" ]] && continue
    printf ':do { /ip firewall address-list add list=%s address=%s comment=%s } on-error={}\n' \
      "$LIST_NAME" "$prefix" "$COMMENT" >> "$v4_rsc"
  done <<< "$v4_prefixes"

  # --- Mikrotik IPv6 .rsc ---
  if [[ -n "$v6_prefixes" ]]; then
    v6_rsc="${MIKROTIK_DIR}/${name}-v6.rsc"
    {
      echo "# Generated: ${generated_at}"
      echo "# Source : RIPEstat announced-prefixes (${name})"
      echo ""
    } > "$v6_rsc"
    while IFS='|' read -r prefix asn; do
      [[ -z "$prefix" ]] && continue
      printf ':do { /ipv6 firewall address-list add list=%s address=%s comment=%s } on-error={}\n' \
        "$LIST_NAME" "$prefix" "$COMMENT" >> "$v6_rsc"
    done <<< "$v6_prefixes"
  fi

  # --- Плоский текстовый список (IPv4 + IPv6) ---
  txt="${TEXT_DIR}/${name}.txt"
  {
    printf '%s\n' "$v4_prefixes" | cut -d'|' -f1
    printf '%s\n' "$v6_prefixes" | cut -d'|' -f1
  } | grep -v '^$' | sort -u > "$txt"

  echo "    wrote $(wc -l < "$txt") prefixes -> ${txt}, ${v4_rsc}"
done
