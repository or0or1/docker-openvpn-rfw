#!/bin/bash

#/sbin/iptables -A FORWARD -i tun0 -s 192.167.0.0/24 -j ACCEPT 
#/sbin/iptables -A FORWARD -i tun0 -s 192.167.1.0/24 -j ACCEPT 
#/sbin/iptables -A FORWARD -i tun0 -s 192.167.2.0/24 -j ACCEPT 
#/sbin/iptables -A FORWARD -i tun0 -s 192.167.3.0/24 -j ACCEPT 
#/sbin/iptables -A FORWARD -i tun0 -s 192.167.4.0/24 -j ACCEPT 
#/sbin/iptables -A FORWARD -i tun0 -s 192.167.5.0/24 -j ACCEPT 
#/sbin/iptables -A FORWARD -i tun0 -s 192.167.6.0/24 -j ACCEPT 
#/sbin/iptables -A FORWARD -i tun0 -s 192.167.7.0/24 -j ACCEPT 
#/sbin/iptables -A FORWARD -i tun0 -s 192.167.8.0/24 -j ACCEPT 
/sbin/iptables -A FORWARD -i tun0 -d 192.168.0.0/24 -j DROP
/sbin/iptables -A FORWARD -i tun0 -d 192.168.1.0/24 -j DROP
#echo "init"
#python /init.py
/usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/nginx/conf/nginx.conf

