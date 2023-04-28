export DIR_NAME=`date +VBDB_%Y%m%d_%H%M%S`
export server_name='VB'




mv VBDB_20140621_085116 $DIR_NAME
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
put $FILE_NAME
bye
EOF

wget http://dbmonitoring.enb.local/test/db_backup_check.php?db_name=$server_name

rm db_backup_check.php?db_name=*

