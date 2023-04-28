#!/bin/sh
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export ORACLE_SID=vb
export TZ=Asia/Tehran


echo '******************************************************************' >> /u01/script/log/Inc0.log
echo 'start-VB-Inc0' >> /u01/script/log/Inc0.log
date >> /u01/script/log/Inc0.log
$ORACLE_HOME/bin/rman target sys/--- cmdfile=/u01/script/vbInc0.rman log=/u01/script/log/Full/"VB-inc0-$(date +"%b-%d-%y-%H:%M").log"
echo 'stop-VB-Inc0:' >> /u01/script/log/Inc0.log
date >> /u01/script/log/Inc0.log
echo '******************************************************************' >> /u01/script/log/Inc0.log

