#!/bin/sh
echo '******************************************************************' >> /home/oracle/scripts/log/Inc1.log
echo 'start-Inc1' >> /home/oracle/scripts/log/Inc1.log
date >> /home/oracle/scripts/log/Inc1.log
rman target / cmdfile=/home/oracle/scripts/Inc1.rman log=/home/oracle/scripts/log/Diff/"Inc1-$(date +"%b-%d-%y-%H:%M").log"
echo 'stop-Inc1:' >> /home/oracle/scripts/log/Inc1.log
date >> /home/oracle/scripts/log/Inc1.log
echo '******************************************************************' >> /home/oracle/scripts/log/Inc1.log