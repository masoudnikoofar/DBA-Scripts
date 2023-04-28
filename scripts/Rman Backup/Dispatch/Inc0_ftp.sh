# oracle dump creator - author : Masoud Nikoofar - run every day by cron
NOW=$(date +"%Y%m%d")
server_name="dispatch"

cd /u01/Backup/Rman/Inc0
HOST=172.50.251.220  #This is the FTP servers host or IP address.
USER=dispatch             #This is the FTP user that has access to the server.
PASS=dispatch_ftp          #This is the password for the FTP user.
ftp -inv $HOST << EOF
user $USER $PASS
mkdir $NOW
cd $NOW
mput *
bye
EOF

wget http://dbmonitoring.enb.local/test/db_backup_check.php?db_name=$server_name

rm db_backup_check.php?db_name=*


