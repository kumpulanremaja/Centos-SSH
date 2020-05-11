#!/bin/bash
# Script BadVPn SSH
# www.hidessh.com


wget -O /bin/badvpn-udpgw "https://www.dropbox.com/s/tgkxdwb03r7w59r/badvpn-udpgw"
chmod +x /bin/badvpn-udpgw
#rcloca
sed -i '$ i\screen -dmS udpvpn /bin/badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000 --max-connections-for-client 10' /etc/rc.local
sed -i '$ i\screen -dmS udpvpn /bin/badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10' /etc/rc.local
#rcautolocal
sed -i '$ i\screen -dmS udpvpn /bin/badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000 --max-connections-for-client 10' /etc/rc.d/rc.local
sed -i '$ i\screen -dmS udpvpn /bin/badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10' /etc/rc.d/rc.local
