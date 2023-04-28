#!/bin/bash
NOW=$(date +"%Y%m%d")
BACKUP_DIR=/u01/Backup/alert_logs
LOG_DIR=$ORACLE_BASE/diag/rdbms/$ORACLE_SID/$ORACLE_SID/trace
mv $LOG_DIR/alert_$ORACLE_SID.log $LOG_DIR/alert_$ORACLE_SID_$NOW.log 
touch $LOG_DIR/alert_$ORACLE_SID.log
tar czvf $BACKUP_DIR/alert_$ORACLE_SID_$NOW.log.tar.gz $LOG_DIR/alert_$ORACLE_SID_$NOW.log
rm -rf $LOG_DIR/alert_$ORACLE_SID_$NOW.log

