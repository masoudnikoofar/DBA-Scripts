use master;
-------------------------------------------------
CREATE TABLE dbo.enbdba_users (LoginName varchar(100),IS_LIMITED varchar(3) default 'NO');
CREATE TABLE dbo.enbdba_users_limits (
LoginName varchar(100),
ServerName varchar(20),
LoginType VARCHAR(100),
ClientHost varchar(100),
program_name varchar(100)
);
-------------------------------------------------
CREATE TABLE dbo.loginData (
	id INT IDENTITY PRIMARY KEY,
	data XML,
	program_name sysname
);
-------------------------------------------------
CREATE VIEW dbo.enbdba_users_limits_log
AS
SELECT id
      ,data.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname') AS EventType
      ,data.value('(/EVENT_INSTANCE/PostTime)[1]', 'datetime') AS PostTime
      ,data.value('(/EVENT_INSTANCE/SPID)[1]', 'int') AS SPID
      ,data.value('(/EVENT_INSTANCE/ServerName)[1]', 'nvarchar(257)') AS ServerName
      ,data.value('(/EVENT_INSTANCE/LoginName)[1]', 'sysname') AS LoginName
      ,data.value('(/EVENT_INSTANCE/LoginType)[1]', 'sysname') AS LoginType
      ,data.value('(/EVENT_INSTANCE/SID)[1]', 'nvarchar(85)') AS SID
      ,data.value('(/EVENT_INSTANCE/ClientHost)[1]', 'sysname') AS ClientHost
      ,data.value('(/EVENT_INSTANCE/IsPooled)[1]', 'bit') AS IsPooled
      ,program_name
FROM loginData;
-------------------------------------------------
--drop trigger enbdba_afterlogon_trigger on all server;
CREATE TRIGGER enbdba_afterlogon_trigger
ON ALL SERVER WITH EXECUTE AS 'sa'
FOR LOGON
AS
BEGIN
	DECLARE @ROW_COUNT int;
	DECLARE @data XML;
	SET @data = EVENTDATA();
	DECLARE @AppName sysname
		   ,@LoginName sysname
		   ,@LoginType sysname;
	SELECT @AppName = [program_name]
	FROM sys.dm_exec_sessions
	WHERE session_id = @data.value('(/EVENT_INSTANCE/SPID)[1]', 'int');
	-------------------------
    SELECT @ROW_COUNT=COUNT(*) FROM dbo.enbdba_users WHERE LoginName=@data.value('(/EVENT_INSTANCE/LoginName)[1]', 'sysname') and is_limited='YES';
	IF @ROW_COUNT>0 
	BEGIN
		SELECT @ROW_COUNT = COUNT(*) FROM dbo.enbdba_users_limits WHERE 
		LoginName=@data.value('(/EVENT_INSTANCE/LoginName)[1]', 'sysname')
		AND ServerName=@data.value('(/EVENT_INSTANCE/ServerName)[1]', 'sysname')
		AND LoginType=@data.value('(/EVENT_INSTANCE/LoginType)[1]', 'sysname')
		AND ClientHost=@data.value('(/EVENT_INSTANCE/ClientHost)[1]', 'sysname')
		AND program_name=@AppName;

		IF @ROW_COUNT<1
		BEGIN
			INSERT INTO loginData(data, program_name) VALUES (@data, @AppName);
			ROLLBACK; 
		END;
	END;
END;
-------------------------------------------------
select * From master.dbo.audit_logins x where x.col_loginname='masoud';