Insert Into [172.50.241.28].mizban_db_log.dbo.CustomError 
select 
[ErrorID]
,[ErrorMsg]
,[UserID]
,[RoleID]
,[CreationDate]
,[IPAddress]
,[URL]
,[StackTrace]
,[Sessions]
,[Cookies]
,[FormParams]
,[QueryString]
from CustomError 
where CreationDate <'2019-02-20';
-------------------


