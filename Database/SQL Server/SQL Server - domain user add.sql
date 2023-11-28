--2016
USE [master]
GO
CREATE LOGIN [ENB\m.nikoofar] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ENB\m.nikoofar]
GO

--2008
USE [master]
GO
CREATE LOGIN [ENB\m.nikoofar] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO
EXEC master..sp_addsrvrolemember @loginame = N'ENB\m.nikoofar', @rolename = N'sysadmin'
GO
