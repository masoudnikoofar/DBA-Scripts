yum install -y python python-requests

mkdir -p /etc/ENBDBA/DBMonitoring/Agents/get_disk_space/
cp * /etc/ENBDBA/DBMonitoring/Agents/get_disk_space/
cp enbdba_dbmonitoring_agent_get_disk_space.service /etc/systemd/system/
chmod 500 /etc/ENBDBA/DBMonitoring/Agents/get_disk_space/get_disk_space.sh
systemctl enable enbdba_dbmonitoring_agent_get_disk_space
systemctl restart enbdba_dbmonitoring_agent_get_disk_space

