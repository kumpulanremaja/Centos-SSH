#!/bin/bash
# Script Auto Installer by HideSSH
# HideSSH

#firewall SSH
firewall-cmd --zone=public --add-port=22/udp --permanent
firewall-cmd --zone=public --add-port=143/udp --permanent

#firewall Dropbear
firewall-cmd --zone=public --add-port=44/udp --permanent
firewall-cmd --zone=public --add-port=77/udp --permanent

#firewall SSL
firewall-cmd --zone=public --add-port=222/udp --permanent
firewall-cmd --zone=public --add-port=443/udp --permanent
firewall-cmd --zone=public --add-port=444/udp --permanent
firewall-cmd --zone=public --add-port=777/udp --permanent

#Squid
firewall-cmd --zone=public --add-port=3128/udp --permanent
firewall-cmd --zone=public --add-port=9090/udp --permanent
firewall-cmd --zone=public --add-port=8080/udp --permanent
firewall-cmd --zone=public --add-port=9000/udp --permanent
firewall-cmd --zone=public --add-port=8888/udp --permanent

#badvpn
firewall-cmd --zone=public --add-port=7300/udp --permanent

#firewall Custom
firewall-cmd --zone=public --add-port=80/udp --permanent
firewall-cmd --zone=public --add-port=25/udp --permanent
firewall-cmd --zone=public --add-port=4433/udp --permanent

#reload firewall
firewall-cmd --reload
