yum install -y python python-requests

mkdir -p /etc/DBA/DBMonitoring/Agents/get_disk_space/
cp * /etc/DBA/DBMonitoring/Agents/get_disk_space/
cp DBA_dbmonitoring_agent_get_disk_space.service /etc/systemd/system/
chmod 500 /etc/DBA/DBMonitoring/Agents/get_disk_space/get_disk_space.sh
systemctl enable dba_dbmonitoring_agent_get_disk_space
systemctl restart dba_dbmonitoring_agent_get_disk_space

