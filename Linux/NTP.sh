systemctl enable ntpd
systemctl stop ntpd
ntpdate 192.168.72.10
systemctl start ntpd
date

cat /etc/ntp.conf | grep 192.168.72.10
date
