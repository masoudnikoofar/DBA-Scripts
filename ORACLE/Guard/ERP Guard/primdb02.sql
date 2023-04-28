*****************************************Primary DB*****************************************
rman

startup force nomount pfile='/home/oracle/init.ora';






connect target /
connect auxiliary sys/dbaEnbankORACLESYS@erp_guard


run
{
allocate channel p1 type disk;
allocate channel p2 type disk;
allocate channel p3 type disk;
allocate channel p4 type disk;
allocate channel p5 type disk;
allocate auxiliary channel x1 type disk;
allocate auxiliary channel x2 type disk;
allocate auxiliary channel x3 type disk;
allocate auxiliary channel x4 type disk;
allocate auxiliary channel x5 type disk;
duplicate target database for standby from active database 
spfile
parameter_value_convert 'erp','erpgrd'
set memory_max_target='10G'
set memory_target='10G'
set sga_max_size='0'
set db_unique_name='erpgrd'
set db_name='erp'
set control_files='/u01/app/oracle/oradata/erpgrd/control01.ctl'
set standby_file_management='auto'
set db_file_name_convert='/u01/app/oracle/oradata/erp/','/u01/app/oracle/oradata/erpgrd/','/u01/app/oracle/oradata/erp/ERP','/u01/app/oracle/oradata/erpgrd/ERP'
set log_file_name_convert='/u01/app/oracle/oradata/erp/','/u01/app/oracle/oradata/erpgrd/','/u01/app/oracle/oradata/erp/ERP','/u01/app/oracle/oradata/erpgrd/ERP'
set log_archive_max_processes='6'
set fal_client='erp_guard'
set fal_server='erp_primary'
set log_archive_dest_2='service=erp async noaffirm 
 valid_for=(online_logfiles,primary_role) 
 db_unique_name=erp'
set log_archive_config='dg_config=(erp,erpgrd)';
}










--shutdown immediate;
--startup mount;
--ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PERFORMANCE;
--ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PROTECTION;
--alter database open





