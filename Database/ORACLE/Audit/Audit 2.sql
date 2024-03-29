/*
BY DEFAULT ORACLE DATABASES DO NOT AUDIT SQL COMMANDS EXECUTED BY THE PRIVILEGED SYS, AND USERS CONNECTING WITH SYSDBA OR SYSOPER PRIVILEGES. IF YOUR DATABASE IS HACKED, THESE PRIVILEGES ARE GOING TO THE BE THE HACKERS FIRST TARGET. FORTUNATELY AUDITING SQL COMMANDS OF THESE PRIVILEGED USERS IS VERY SIMPLE:
*/
ALTER SYSTEM SET AUDIT_SYS_OPERATIONS=TRUE SCOPE=SPFILE;
/*
NOTE: THE COMMAND ABOVE WOULD ENABLE AUDITING FROM THE DATABASE, BUT NOT THE DATABASE VAULT INFORMATION, INTO THE TABLE SYS.AUD$. THERE ARE ACTUALLY FOUR DATABASE AUDITING TYPES: OS, DB, EXTENDED, AND XML.
*/
ALTER SYSTEM SET AUDIT_TRAIL=DB,EXTENDED SCOPE=SPFILE;

AUDIT ALL BY USERNAME BY ACCESS;
AUDIT SELECT TABLE, UPDATE TABLE, INSERT TABLE, DELETE TABLE BY USERNAME BY ACCESS;
AUDIT EXECUTE PROCEDURE BY USERNAME BY ACCESS;



SELECT 'AUDIT ALL BY ' ||T.USERNAME || ' BY ACCESS;' FROM DBA_USERS T WHERE T.USERNAME IN (...)
UNION ALL
SELECT 'AUDIT SELECT TABLE, UPDATE TABLE, INSERT TABLE, DELETE TABLE BY ' ||T.USERNAME || ' BY ACCESS;' FROM DBA_USERS T WHERE T.USERNAME IN (...)
UNION ALL
SELECT 'AUDIT EXECUTE PROCEDURE BY ' ||T.USERNAME || ' BY ACCESS;' FROM DBA_USERS T WHERE T.USERNAME IN (...)
