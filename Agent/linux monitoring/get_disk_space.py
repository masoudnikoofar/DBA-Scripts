"""
ENBDBA Monitoring Agent - Disk Usage
By Masoud Nikoofar - 2018
yum install -y python-requests
Note: there should be a get_disk_space.config file next to this file, and in this file the first line should include just a web service URL, and other lines are partitions we are going to monitor
"""
print "  _____ _   _  ____              _     "
print " | ____| \ | || __ )  __ _ _ __ | | __ "
print " |  _| |  \| ||  _ \ / _` | '_ \| |/ / "
print " | |___| |\  || |_) | (_| | | | |   <  "
print " |_____|_| \_||____/ \__,_|_| |_|_|\_\ "
##############################################################
import os
import requests
import json
import socket
with open("get_disk_space.config","r") as configfile:
	data=configfile.read();
configs = data.split();
config_url = configs[0];
config_drives = configs[1].split(',');
ip_address = socket.gethostbyname(socket.gethostname());
i = 0
while i < len(config_drives):
	st = os.statvfs(config_drives[i])
	total_space = st.f_frsize * st.f_blocks 
	free_space  = st.f_frsize * st.f_bavail
	data = json.dumps({'ip_address': ip_address, 'drive': config_drives[i], 'total_space': total_space, 'free_space': free_space})
	response = requests.post(config_url, data=data)
	i+=1

