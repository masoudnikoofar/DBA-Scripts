sqlplus / as sysdba
recover managed standby database using current logfile disconnect from session;


--recover managed standby database cancel;




recover managed standby database cancel;
alter database open;

recover managed standby database using current logfile disconnect from session;




alter system set standby_file_management=manual;

recover managed standby database cancel;
recover managed standby database using current logfile disconnect from session;



alter system set standby_file_management=auto;