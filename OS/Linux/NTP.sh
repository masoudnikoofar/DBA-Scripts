systemctl enable ntpd
systemctl stop ntpd
ntpdate SERVER
systemctl start ntpd
date

cat /etc/ntp.conf | grep SERVER
date
