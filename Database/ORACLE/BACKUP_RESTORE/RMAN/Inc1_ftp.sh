# oracle dump creator - author : Masoud Nikoofar - run every day by cron
NOW=$(date +"%Y%m%d")
server_name="SERVER NAME"

cd /u01/Backup/Rman/Inc1
HOST=FTP_SERVER_IP_ADDRESS  #This is the FTP servers host or IP address.
USER=FTP_SERVER_USERNAME    #This is the FTP user that has access to the server.
PASS=FTP_SERVER_PASSWORD    #This is the password for the FTP user.
ftp -inv $HOST << EOF
user $USER $PASS
mkdir $NOW
cd $NOW
mput *
bye
EOF
