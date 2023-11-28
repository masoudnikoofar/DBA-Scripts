export DIR_NAME=`date +DUMP_%Y%m%d_%H%M%S`
export FILE_NAME=`date +FullEXP_%Y%m%d_%H%M%S.dmp`
export LOG_FILE_NAME=`date +FullEXP_%Y%m%d_%H%M%S.log`
mkdir -p /Backups/$DIR_NAME

expdp USER/PASS FULL=Y DIRECTORY=MASOUD_DUMPS DUMPFILE=$FILE_NAME LOGFILE=$LOG_FILE_NAME COMPRESSION=ALL REUSE_DUMPFILES=N encryption=all encryption_password=ENCRYPTION_KEY parallel=10
mv /Backups/$FILE_NAME /Backups/$DIR_NAME/
mv /Backups/$LOG_FILE_NAME /Backups/$DIR_NAME/

