#!/bin/bash
# Script Auto Installer by HideSSH
# HideSSH
# initialisasi var

#Requirement
if [ ! -e /usr/bin/curl ]; then
   yum -y update && yum -y upgrade
   yum -y install curl
fi

# initializing var
OS=`uname -m`;
MYIP=$(curl -4 icanhazip.com)
if [ $MYIP = "" ]; then
   MYIP=`ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1`;
fi
MYIP2="s/xxxxxxxxx/$MYIP/g";

# update software server
yum update -y

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# go to root
cd

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service sshd restart

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.d/rc.local

# install wget and curl
yum -y install wget curl

# setting repo centos 64bit
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# setting rpmforge
wget https://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el7/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
rpm -Uvh rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
# remove unused
yum -y remove sendmail;
yum -y remove httpd;
yum -y remove cyrus-sasl

# update
yum -y update

# install webserver
yum -y install nginx php-fpm php-cli
service nginx restart
service php-fpm restart
chkconfig nginx on
chkconfig php-fpm on

# install essential package
yum -y install rrdtool screen iftop htop nmap bc nethogs vnstat ngrep mtr git zsh mrtg unrar rsyslog rkhunter mrtg net-snmp net-snmp-utils expect nano bind-utils
yum -y groupinstall 'Development Tools'
yum -y install cmake
yum -y --enablerepo=rpmforge install axel sslh ptunnel unrar

# matiin exim
service exim stop
chkconfig exim off

#install Netstat
cd
yum -y install net-tools

# setting vnstat
vnstat -u -i eth0
echo "MAILTO=root" > /etc/cron.d/vnstat
echo "*/5 * * * * root /usr/sbin/vnstat.cron" >> /etc/cron.d/vnstat
service vnstat restart
chkconfig vnstat on

# install screenfetch
cd
wget https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/app/screenfetch-dev
mv screenfetch-dev /usr/bin/screenfetch
chmod +x /usr/bin/screenfetch
echo "clear" >> .bash_profile
echo "screenfetch" >> .bash_profile

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://www.dropbox.com/s/tgkxdwb03r7w59r/badvpn-udpgw"
wget https://raw.githubusercontent.com/kumpulanremaja/Centos-SSH/master/bad.sh
#port BadVPN 7300
sed -i '$ i\/root/bad.sh' /etc/rc.local
sed -i '$ i\/root/bad.sh' /etc/rc.d/rc.local

chmod +x /usr/bin/badvpn-udpgw
chmod +x /root/bad.sh
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10

# install fail2ban
cd
yum -y install fail2ban
service fail2ban restart
chkconfig fail2ban on

#setting dasar SSH Web 
#banner SSH
wget -O /etc/banner-akun "https://raw.githubusercontent.com/kumpulanremaja/Centos-SSH/master/banner"
chmod +x banner
cd
sed -i '/Banner none/a Banner /etc/banner-akun' /etc/ssh/sshd_config

# setting port ssh
cd
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port  22/g' /etc/ssh/sshd_config
service sshd restart
chkconfig sshd on

# install dropbear
yum -y install dropbear
echo "OPTIONS=\"-b /etc/banner-akun -p 44 -p 77\"" > /etc/sysconfig/dropbear
echo "/bin/false" >> /etc/shells
service dropbear restart
chkconfig dropbear on

# install squid
yum -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/kumpulanremaja/Centos-SSH/master/squid.conf"
sed -i $MYIP2 /etc/squid/squid.conf;
service squid restart
chkconfig squid on

#install stunnel
cd
yum -y install stunnel
wget -O /etc/rc.d/init.d/stunnel "https://raw.githubusercontent.com/kumpulanremaja/Centos-SSH/master/stunnel-init"
wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/kumpulanremaja/Centos-SSH/master/stunnel-sslport"
wget -O /etc/stunnel/stunnel.pem "https://raw.githubusercontent.com/kumpulanremaja/Centos-SSH/master/stunnel.pem"
chmod +x /etc/init.d/stunnel
service stunnel restart
chkconfig stunnel on

# download script all Menu
cd
wget https://raw.githubusercontent.com/shigeno143/OCSPanelCentos6/master/install-premiumscript.sh -O - -o /dev/null|sh
chmod +x premiumscript.sh
bash premiumscript.sh


# cron
cd
chkconfig crond on
service crond stop
#autoreboot
echo "0 */12 * * * root /bin/sh /usr/bin/reboot" > /etc/cron.d/reboot
# finalizing
service nginx start
service php-fpm start
service vnstat restart
service snmpd restart
service sshd restart
service dropbear restart
service fail2ban restart
service squid restart
service crond start
chkconfig crond on

#clearing history
history -c

# info
clear
echo " "
echo "INSTALLATION COMPLETE!"
echo " "
echo "--------------------------- Setup Server Information ---------------------------"
echo "                                Copyright HideSSH                       		  "
echo "--------------------------------------------------------------------------------"
echo "Server Included"  | tee -a log-install.txt
echo "   - Timezone    : Asia/jakarta (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban    : [ON]"  | tee -a log-install.txt
echo "   - IPtables    : [ON]"  | tee -a log-install.txt
echo "   - DDeflate    : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot : [OFF]"  | tee -a log-install.txt
echo "   - IPv6        : [OFF]"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Stunnel     : 443, 222, 777, 444"  | tee -a log-install.txt
echo "   - Dropbear    : 44, 77"  | tee -a log-install.txt
echo "   - Squid Proxy : 3128 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Squid Proxy SSL : 9090 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn      : 7300"  | tee -a log-install.txt
echo "   - Nginx       : 85"  | tee -a log-install.txt

echo ""  | tee -a log-install.txt
echo "Server Tools"  | tee -a log-install.txt
echo "   - htop"  | tee -a log-install.txt
echo "   - iftop"  | tee -a log-install.txt
echo "   - mtr"  | tee -a log-install.txt
echo "   - nethogs"  | tee -a log-install.txt
echo "   - screenfetch"  | tee -a log-install.txt
echo "------------------------------ HideSSH -----------------------------"

#install firewall all port
cd 
wget https://raw.githubusercontent.com/kumpulanremaja/Centos-SSH/master/firewall.sh
bash firewall.sh

rm -rf centos7.sh
