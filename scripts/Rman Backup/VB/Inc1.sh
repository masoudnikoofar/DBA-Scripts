#!/bin/sh
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export ORACLE_SID=vb
export TZ=Asia/Tehran


echo '******************************************************************' >> /u01/script/log/Inc1.log
echo 'start-VB-Inc1' >> /u01/script/log/Inc1.log
date >> /u01/script/log/Inc1.log
$ORACLE_HOME/bin/rman target sys/--- cmdfile=/u01/script/vbInc1.rman log=/u01/script/log/Diff/"VB-inc1-$(date +"%b-%d-%y-%H:%M").log"
echo 'stop-VB-Inc1:' >> /u01/script/log/Inc1.log
date >> /u01/script/log/Inc1.log
echo '******************************************************************' >> /u01/script/log/Inc1.log
