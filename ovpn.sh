# install openvpn
wget -O /etc/openvpn/openvpn.zip "https://github.com/khairilg/script-jualan-ssh-vpn/raw/master/conf/openvpn-key.zip"
cd /etc/openvpn/
unzip openvpn.zip
wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/conf/1194-centos.conf"
if [ "$OS" == "x86_64" ]; then
  wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/conf/1194-centos64.conf"
fi
wget -O /etc/iptables.up.rules "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/conf/iptables.up.rules"
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.d/rc.local
MYIP=`curl icanhazip.com`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
sed -i $MYIP2 /etc/iptables.up.rules;
sed -i 's/venet0/eth0/g' /etc/iptables.up.rules
iptables-restore < /etc/iptables.up.rules
sysctl -w net.ipv4.ip_forward=1
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
service openvpn restart
chkconfig openvpn on
cd
