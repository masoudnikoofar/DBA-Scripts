export DIR_NAME=`date +VBDB_%Y%m%d_%H%M%S`
export server_name='VB'

mkdir -p /u01/Backup/$DIR_NAME

$ORACLE_HOME/bin/sqlplus sys/10069 as sysdba @/u01/script/SCN.rman >/u01/Backup/$DIR_NAME/VB_SCN_Before_Rman_$(date +"%Y%m%d_%H%M%S").log
$ORACLE_HOME/bin/rman target sys/10069 cmdfile=/u01/script/Rman_inc0_VB.rman log=/u01/Backup/$DIR_NAME/VB_inc0_$(date +"%Y%m%d_%H%M%S").log
$ORACLE_HOME/bin/sqlplus sys/10069 as sysdba @/u01/script/SCN.rman >/u01/Backup/$DIR_NAME/VB_SCN_After_Rman_$(date +"%Y%m%d_%H%M%S").log


cp -p -R /u01/app/oracle/flash_recovery_area /u01/Backup/$DIR_NAME


#ftp
#cd /u01/Backup
#cp -p -R $DIR_NAME /u01/Oracle_Backup_Mount
tar -zcvf /u01/Backup/$DIR_NAME.tar.gz /u01/Backup/$DIR_NAME
rm -Rf /u01/Backup/$DIR_NAME


export FILE_NAME=$DIR_NAME.tar.gz

HOST=172.50.251.220  #This is the FTP servers host or IP address.
USER=vb             #This is the FTP user that has access to the server.
PASS=vb_ftp          #This is the password for the FTP user.
ftp -inv $HOST << EOF
user $USER $PASS
lcd  /u01/Backup/
put $FILE_NAME
bye
EOF

wget http://dbmonitoring.enb.local/test/db_backup_check.php?db_name=$server_name

rm db_backup_check.php?db_name=*

