#!/bin/bash
# Script BadVPn SSH
# www.hidessh.com


wget -O /usr/bin/badvpn-udpgw "https://www.dropbox.com/s/tgkxdwb03r7w59r/badvpn-udpgw"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000 --max-connections-for-client 10' /etc/rc.local
sed -i '$ i\badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000 --max-connections-for-client 10' /etc/rc.d/rc.local
sed -i '$ i\badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10' /etc/rc.local
sed -i '$ i\badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10' /etc/rc.d/rc.local
sed -i '$ i\badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10' /etc/rc.local
sed -i '$ i\badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10' /etc/rc.d/rc.local

badvpn-udpgw --listen-addr 127.0.0.1:7100
badvpn-udpgw --listen-addr 127.0.0.1:7200
badvpn-udpgw --listen-addr 127.0.0.1:7300


