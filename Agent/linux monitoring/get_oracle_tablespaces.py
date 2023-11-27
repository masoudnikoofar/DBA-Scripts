"""
ENBDBA Monitoring Agent - Oracle Tablespaces
By Masoud Nikoofar - 2018
yum install -y python-requests
Note: there should be a get_disk_space.config file next to this file, and in this file the first line should include just a web service URL
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

os.system('sqlplus / as sysdba @get_oracle_tablespaces.sql')
with open("get_oracle_tablespaces.csv","r") as resultfile:
	results=resultfile.read().splitlines()

with open("get_oracle_tablespaces.config","r") as configfile:
	data=configfile.read()
configs = data.split()
config_url = configs[0]
#config_drives = configs[1].split(',')
ip_address = socket.gethostbyname(socket.gethostname())
i = 0
while i < len(results):
	#print results[i]
	result=results[i].split(',')
	data = json.dumps({'ip_address': ip_address, 'sid': 'orcl', 'tablespace': result[0], 'total_space_mb': result[1], 'used_space_mb': result[2], 'data_files_count': result[3]})
	response = requests.post(config_url, data=data)
	i += 1