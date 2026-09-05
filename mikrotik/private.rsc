# Generated: 2026-09-05T15:01:36Z
# Source : text/private.txt

:do { /ip firewall address-list add list=to_vpn address=0.0.0.0/8 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=10.0.0.0/8 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=100.64.0.0/10 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=127.0.0.0/8 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=169.254.0.0/16 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=172.16.0.0/12 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=192.0.0.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=192.0.2.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=192.88.99.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=192.168.0.0/16 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=198.18.0.0/15 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=198.51.100.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=203.0.113.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=224.0.0.0/3 comment=rbgeoip timeout=30d } on-error={}
