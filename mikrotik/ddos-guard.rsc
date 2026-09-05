# Generated: 2026-09-05T15:01:33Z
# Source : text/ddos-guard.txt

:do { /ip firewall address-list add list=to_vpn address=45.10.240.0/23 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=45.10.243.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=45.155.60.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=91.192.92.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=91.215.40.0/22 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=95.129.232.0/23 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=95.129.234.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=95.129.236.0/23 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=95.129.238.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=153.80.233.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=176.57.64.0/22 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=185.129.100.0/22 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=185.149.120.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=185.178.208.0/22 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=185.215.4.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=185.223.92.0/24 comment=rbgeoip timeout=30d } on-error={}
:do { /ip firewall address-list add list=to_vpn address=217.114.42.0/24 comment=rbgeoip timeout=30d } on-error={}
