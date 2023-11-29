--truncate table master.dbo.audit_logins 
Create Table master.dbo.audit_logins
(
Col_loginName varchar (50),
Col_LoginType varchar (50),
Col_LoginTime datetime,
Col_ClientHost varchar (50) 
);
-------------------------------------------------
drop trigger masoud_dba_afterlogon_trigger on all server
-------------------------------------------------
Create  TRIGGER masoud_dba_afterlogon_trigger
ON ALL SERVER WITH EXECUTE AS 'sa'
FOR LOGON
AS
BEGIN
       
	   declare @LogonTriggerData xml          
       set @LogonTriggerData = eventdata() ;
	   /*
	   Insert into master..audit_logins 
       Select @LogonTriggerData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(50)'),
		  @LogonTriggerData.value('(/EVENT_INSTANCE/LoginType)[1]', 'varchar(50)'),
              @LogonTriggerData.value('(/EVENT_INSTANCE/PostTime)[1]', 'datetime'),         
              @LogonTriggerData.value('(/EVENT_INSTANCE/ClientHost)[1]', 'varchar(50)')          ;
	   */
	  /* if (@LogonTriggerData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(50)')='masoud') and 
	   (@LogonTriggerData.value('(/EVENT_INSTANCE/LoginType)[1]', 'varchar(50)')='SQL Login')
			rollback;
       */
end;
-------------------------------------------------
select * From master.dbo.audit_logins x where x.col_loginname='masoud';