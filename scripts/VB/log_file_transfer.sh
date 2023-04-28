export DIR_NAME=`date +VBDB_redologfile_%Y%m%d_%H%M%S`
export server_name=VB

HOST=172.50.251.220  #This is the FTP servers host or IP address.
USER=vb              #This is the FTP user that has access to the server.
PASS=vb_ftp          #This is the password for the FTP user.
ftp -inv $HOST << EOF
user $USER $PASS
cd DBS
cd $server_name
cd redologfiles
mkdir $DIR_NAME
cd $DIR_NAME
lcd /u01/app/oracle/oradata/vb/
mput redo01.log
mput redo02.log
mput redo03.log
bye
EOF


