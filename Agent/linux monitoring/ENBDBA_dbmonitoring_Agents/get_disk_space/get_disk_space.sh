#!/bin/bash
cd /etc/DBA/DBMonitoring/Agents/get_disk_space/
while true
do
        python /etc/DBA/DBMonitoring/Agents/get_disk_space/get_disk_space.py
        sleep 300
done

