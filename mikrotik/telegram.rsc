# Generated: 2026-09-05T15:01:37Z
# Source : text/telegram.txt

:do { /ip firewall address-list add list=to_vpn address=91.105.192.0/23 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=91.108.4.0/22 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=91.108.8.0/21 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=91.108.16.0/21 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=91.108.56.0/22 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=95.161.64.0/20 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=149.154.160.0/20 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=185.76.151.0/24 comment=rbgeoip timeout=30d } on-error={}
