archive log list
show parameter recovery_file_dest
alter system set log_archive_dest_1='LOCATION=/u02/app/oracle/oradata/orcl/arch' scope = both;
shutdown immediate;
STARTUP MOUNT
alter database archivelog;
--alter database noarchivelog;
ALTER DATABASE OPEN;

alter system switch logfile;
