export DIR_NAME=`date +VBDB_%Y%m%d_%H%M%S_EXP`
export FILE_NAME=`date +VBDB_FullEXP_%Y%m%d_%H%M%S.dmp`
export LOG_FILE_NAME=`date +VBDB_FullEXP_%Y%m%d_%H%M%S.dmp`
mkdir -p /u01/Backup/vb_dump_file/
mkdir -p /u01/Backup/$DIR_NAME



expdp system/10069 FULL=Y DIRECTORY=Dump_File_Dir DUMPFILE=$FILE_NAME LOGFILE=$LOG_FILE_NAME COMPRESSION=ALL REUSE_DUMPFILES=N
cp -p -R /u01/Backup/vb_dump_file /u01/Backup/$DIR_NAME/
rm -Rf /u01/Backup/vb_dump_file/

