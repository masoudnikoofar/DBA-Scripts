CREATE USER USER_NAME IDENTIFIED BY PASSWORD 
ACCOUNT LOCK
DEFAULT TABLESPACE TBS_NAME
QUOTA UNLIMITED ON TBS_NAME
PROFILE PROFILE_NAME;

ALTER USER USER_NAME IDENTIFIED BY PASSWORD 
ACCOUNT LOCK
DEFAULT TABLESPACE TBS_NAME
QUOTA UNLIMITED ON TBS_NAME
PROFILE PROFILE_NAME;

SELECT * FROM DBA_USERS;
SELECT * FROM USER$;

DROP USER USER_NAME CASCADE;

--CHECK ROLES AND PRIVS
SELECT UTL_INADDR.GET_HOST_ADDRESS,B.INSTANCE_NAME,B.HOST_NAME,A.USERNAME,A.PROFILE,A.ACCOUNT_STATUS,TO_CHAR(A.CREATED,'YYYY/MM/DD','NLS_CALENDAR=PERSIAN') AS CREATED
FROM DBA_USERS A,V$INSTANCE B
ORDER BY A.ACCOUNT_STATUS,A.USERNAME;
SELECT * FROM DBA_TAB_PRIVS 
SELECT * FROM DBA_ROLE_PRIVS ORDER BY 1,2;
SELECT * FROM DBA_SYS_PRIVS ORDER BY 1,2;
SELECT * FROM DBA_ROLE_PRIVS X WHERE X.GRANTED_ROLE='CONNECT';