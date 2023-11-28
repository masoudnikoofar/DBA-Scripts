*****************************************Primary DB*****************************************
rman







connect target /
connect auxiliary sys/dbaEnbankORACLESYS@TFRAYANEN_GUARD


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
parameter_value_convert 'tfrayanen','tfrayanst'
set db_unique_name='tfrayanst'
set db_name='tfrayane'
set control_files='/u01/oracle/oradata/tfrayanst/control01.ctl'
set standby_file_management='auto'
set db_file_name_convert='/u01/oracle/oradata/tfrayanen/','/u01/oracle/oradata/tfrayanst/','/u01/oracle/oradata/TF_DEVINT/','/u01/oracle/oradata/tfrayanst/'
set log_file_name_convert='/u01/oracle/oradata/tfrayanen/','/u01/oracle/oradata/tfrayanst/'
set log_archive_max_processes='5'
set fal_client='tfrayanst'
set fal_server='tfrayanen'
set log_archive_config='dg_config=(tfrayanen,tfrayanst)';
}









--shutdown immediate;
--startup mount;
--ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PERFORMANCE;
--ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PROTECTION;
--alter database open





