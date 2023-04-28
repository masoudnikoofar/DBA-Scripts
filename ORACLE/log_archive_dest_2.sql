alter system set log_archive_dest_2 ='LOCATION=/u02/app/oracle/oradata/orcl/archivelogs/ valid_for=(all_logfiles,all_rols) db_unique_name=vb' scope=spfile;
alter system set log_archive_dest_2 ='LOCATION=/u02/app/oracle/oradata/orcl/archivelogs/ valid_for=(all_logfiles,all_rols) db_unique_name=vb' scope=spfile;

alter system set log_archive_dest_1 ='LOCATION=/u01/app/oracle/oradata/orcl/archivelogs/' scope=spfile;
alter system set log_archive_dest_2 ='LOCATION=/u02/app/oracle/oradata/orcl/archivelogs/' scope=spfile;