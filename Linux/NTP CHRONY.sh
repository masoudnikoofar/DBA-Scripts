yum install -y chrony
systemctl enable chronyd

vi /etc/chrony.conf 


systemctl start chronyd



chronyc tracking
chronyc sources -v 