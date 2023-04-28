




recover managed standby database cancel;


select thread#,group#,sequence#,bytes,archived,status from v$log order by 1,2;
select thread#,group#,sequence#,bytes,archived,status from v$standby_log order by 1,2;

alter database drop standby logfile group 7;
alter database drop standby logfile group 8;
alter database drop standby logfile group 9;
alter database drop standby logfile group 10;
alter database drop standby logfile group 11;
alter database drop standby logfile group 12;
alter database drop standby logfile group 13;


alter database add standby logfile thread 1 group 7  '/u01/app/oracle/oradata/erp/standbyredo01.log' size 1073741824   reuse;
alter database add standby logfile thread 1 group 8  '/u01/app/oracle/oradata/erp/standbyredo02.log' size 1073741824   reuse;
alter database add standby logfile thread 1 group 9  '/u01/app/oracle/oradata/erp/standbyredo03.log' size 1073741824   reuse;
alter database add standby logfile thread 1 group 10  '/u01/app/oracle/oradata/erp/standbyredo04.log' size 1073741824  reuse;
alter database add standby logfile thread 1 group 11  '/u01/app/oracle/oradata/erp/standbyredo05.log' size 1073741824  reuse;
alter database add standby logfile thread 1 group 12  '/u01/app/oracle/oradata/erp/standbyredo06.log' size 1073741824  reuse;
alter database add standby logfile thread 1 group 13  '/u01/app/oracle/oradata/erp/standbyredo07.log' size 1073741824  reuse;


recover managed standby database using current logfile disconnect from session;