#!/bin/bash
# Script Auto Installer by HideSSH
# HideSSH

#firewall SSH
firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --zone=public --add-port=143/tcp --permanent

#firewall Dropbear
firewall-cmd --zone=public --add-port=44/tcp --permanent
firewall-cmd --zone=public --add-port=77/tcp --permanent

#firewall SSL
firewall-cmd --zone=public --add-port=222/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=444/tcp --permanent
firewall-cmd --zone=public --add-port=777/tcp --permanent

#Squid
firewall-cmd --zone=public --add-port=3128/tcp --permanent
firewall-cmd --zone=public --add-port=9090/tcp --permanent
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-port=9000/tcp --permanent
firewall-cmd --zone=public --add-port=8888/tcp --permanent

#badvpn
firewall-cmd --zone=public --add-port=7300/tcp --permanent

#firewall Custom
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=25/tcp --permanent
firewall-cmd --zone=public --add-port=4433/tcp --permanent

#reload firewall
firewall-cmd --reload
