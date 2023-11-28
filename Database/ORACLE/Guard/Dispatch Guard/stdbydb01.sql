*****************************************Standby DB*****************************************
startup nomount pfile='/home/oracle/init.ora';


show parameter fal_client;
show parameter fal_server;
alter system set fal_server=dispatch_primary; 
alter system set fal_client=dispatch_guard; 




shutdown abort;
startup nomount pfile='/home/oracle/init.ora';

---primdb02.sql
