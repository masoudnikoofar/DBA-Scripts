#!/bin/sh
echo '******************************************************************' >> /home/oracle/scripts/log/Inc0.log
echo 'start-Inc0' >> /home/oracle/scripts/log/Inc0.log
date >> /home/oracle/scripts/log/Inc0.log
rman target / cmdfile=/home/oracle/scripts/Inc0.rman log=/home/oracle/scripts/log/Full/"Inc0-$(date +"%b-%d-%y-%H:%M").log"
echo 'stop-Inc0:' >> /home/oracle/scripts/log/Inc0.log
date >> /home/oracle/scripts/log/Inc0.log
echo '******************************************************************' >> /home/oracle/scripts/log/Inc0.log
sh Inc0_ftp.sh