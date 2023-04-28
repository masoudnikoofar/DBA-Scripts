#ENBDBA Monitoring Agent - Disk Usage
#By Masoud Nikoofar - 2018
#yum install -y python-requests
print "    _______   ______  ____  ____  ___                __  ___            _ __             _                ___                    __   ";
print "   / ____/ | / / __ )/ __ \/ __ )/   |              /  |/  /___  ____  (_) /_____  _____(_)___  ____ _   /   | ____ ____  ____  / /_  ";
print "  / __/ /  |/ / __  / / / / __  / /| |    ______   / /|_/ / __ \/ __ \/ / __/ __ \/ ___/ / __ \/ __ `/  / /| |/ __ `/ _ \/ __ \/ __/  ";
print " / /___/ /|  / /_/ / /_/ / /_/ / ___ |   /_____/  / /  / / /_/ / / / / / /_/ /_/ / /  / / / / / /_/ /  / ___ / /_/ /  __/ / / / /_    ";
print "/_____/_/ |_/_____/_____/_____/_/  |_|           /_/  /_/\____/_/ /_/_/\__/\____/_/  /_/_/ /_/\__, /  /_/  |_\__, /\___/_/ /_/\__/    ";
print "                                                                                             /____/         /____/                    ";
print "                                                                                                                                      ";
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
	i += 1
