*****************************************Primary DB*****************************************
archive log list;
shutdown immediate;
STARTUP MOUNT;
alter database archivelog;
ALTER DATABASE OPEN;
archive log list;

select force_logging from v$database;
alter database force logging;

show parameter db_name
show parameter db_unique_name

ALTER SYSTEM SET LOG_ARCHIVE_CONFIG='DG_CONFIG=(db_unique_name_prim,db_unique_name_stdby)';























select bytes from v$log;
ALTER DATABASE ADD STANDBY LOGFILE '/u01/app/oracle/oradata/orcl/standbyredo01.log' SIZE 10737418240 reuse;
ALTER DATABASE ADD STANDBY LOGFILE '/u01/app/oracle/oradata/orcl/standbyredo02.log' SIZE 10737418240 reuse;
ALTER DATABASE ADD STANDBY LOGFILE '/u01/app/oracle/oradata/orcl/standbyredo03.log' SIZE 10737418240 reuse;
ALTER DATABASE ADD STANDBY LOGFILE '/u01/app/oracle/oradata/orcl/standbyredo04.log' SIZE 10737418240 reuse;
ALTER DATABASE ADD STANDBY LOGFILE '/u01/app/oracle/oradata/orcl/standbyredo05.log' SIZE 10737418240 reuse;
ALTER DATABASE ADD STANDBY LOGFILE '/u01/app/oracle/oradata/orcl/standbyredo06.log' SIZE 10737418240 reuse;
ALTER DATABASE ADD STANDBY LOGFILE '/u01/app/oracle/oradata/orcl/standbyredo07.log' SIZE 10737418240 reuse;


col member format a50;
select group#,STATUS,TYPE,MEMBER from v$logfile where type='STANDBY';
select GROUP#,BYTES,BLOCKSIZE,USED,ARCHIVED,STATUS from v$standby_log;

show parameter log_archive_config;
select * from v$dataguard_config;
alter system set log_archive_config='dg_config=(enbank,mbguard)';
show parameter log_archive_config;
select * from v$dataguard_config;

show parameter log_archive_dest_1;
show parameter log_archive_dest_2;
alter system set log_archive_dest_2='service=mbguard async noaffirm
valid_for=(online_logfiles,primary_role)
db_unique_name=mbguard';
show parameter log_archive_dest_2;

show parameter log_archive_dest_state_2;
alter system set log_archive_dest_state_2=enable;
show parameter log_archive_dest_state_2;


show parameter db_file_name_convert;
select name from V$datafile;
select name from v$tempfile;
--must apply on standby db
--alter system set db_file_name_convert=('/u01/app/oracle/oradata/primdb','/u01/app/oracle/oradata/stdbydb');

show parameter log_file_name_convert;
select member from v$logfile;
--must apply on standby db
--alter system set log_file_name_convert=('/u01/app/oracle/oradata/primdb','/u01/app/oracle/oradata/stdbydb','/u01/app/oracle/fast_recovery_area/PRIMDB/onlinelog','/u01/app/oracle/fast_recovery_area/STDBYDB/onlinelog');

show parameter standby_file_management;
alter system set standby_file_management=auto;

show parameter remote_login_passwordfile;
alter system set remote_login_passwordfile=exclusive;

create pfile='/home/oracle/init.ora' from spfile;


show parameter fal_client;
show parameter fal_server;
alter system set fal_server=mbguard; 
alter system set fal_client=mbprim; 


