

SELECT name, physical_name AS CurrentLocation, state_desc  
FROM sys.master_files  
WHERE database_id = DB_ID(N'arzireport'); 

ALTER DATABASE db_name SET OFFLINE;  

ALTER DATABASE db_name MODIFY FILE ( NAME = file_name, FILENAME = 'new_path' );  


ALTER DATABASE db_name SET ONLINE;  

