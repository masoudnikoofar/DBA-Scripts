*****************************************Primary DB*****************************************
rman

startup nomount pfile='/home/oracle/init.ora';






connect target /
connect auxiliary sys/dbaEnbankORACLESYS@dispatch_guard


run
{
allocate channel p1 type disk;
allocate channel p2 type disk;
allocate channel p3 type disk;
allocate auxiliary channel x1 type disk;
allocate auxiliary channel x2 type disk;
allocate auxiliary channel x3 type disk;
duplicate target database for standby from active database 
spfile
parameter_value_convert 'orcl','dispgrd'
set memory_max_target='30G'
set memory_target='30G'
set db_unique_name='dispgrd'
set db_name='orcl'
set control_files='/u01/app/oracle/oradata/dispgrd/control01.ctl'
set standby_file_management='auto'
set db_file_name_convert='/u01/app/oracle/oradata/ORCL/datafile/','/u01/app/oracle/oradata/DISPGRD/datafile/','/u01/app/oracle/oradata/orcl/','/u01/app/oracle/oradata/dispgrd/','/u02/app/oracle/oradata/orcl/TEMP','/u01/app/oracle/oradata/dispgrd/TEMP'
set log_file_name_convert='/u01/app/oracle/oradata/orcl/','/u01/app/oracle/oradata/dispgrd/'
set log_archive_max_processes='6'
set fal_client='dispatch_guard'
set fal_server='dispatch_primary'
set log_archive_config='dg_config=(orcl,dispgrd)';
}













--shutdown immediate;
--startup mount;
--ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PERFORMANCE;
--ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PROTECTION;
--alter database open





