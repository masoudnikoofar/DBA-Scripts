
-------------------------------------------------------------------
SELECT USERNAME,PROFILE,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE FROM DBA_USERS;
SELECT USERNAME,PROFILE,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE FROM DBA_USERS where account_status='OPEN';
-------------------------------------------------------------------
SELECT DISTINCT PROFILE FROM DBA_PROFILES;

CREATE PROFILE PROFILE_NAME LIMIT
  PASSWORD_LIFE_TIME UNLIMITED
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  PASSWORD_VERIFY_FUNCTION ORA12C_STIG_VERIFY_FUNCTION
  FAILED_LOGIN_ATTEMPTS 3;
ALTER PROFILE PROFILE_NAME LIMIT FAILED_LOGIN_ATTEMPTS 3;
ALTER PROFILE PROFILE_NAME LIMIT PASSWORD_VERIFY_FUNCTION VERIFY_FUNCTION_11G;
ALTER PROFILE PROFILE_NAME LIMIT PASSWORD_VERIFY_FUNCTION ORA12C_STIG_VERIFY_FUNCTION;

sqlplus / as sysdba @$ORACLE_HOME/rdbms/admin/utlpwdmg.sql
ALTER PROFILE PROFILE_NAME LIMIT PASSWORD_VERIFY_FUNCTION VERIFY_FUNCTION_11G;

DROP PROFILE PROFILE_NAME;

CREATE PROFILE DBA_USERS_PROFILE LIMIT
  PASSWORD_LIFE_TIME UNLIMITED
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  PASSWORD_VERIFY_FUNCTION ORA12C_STIG_VERIFY_FUNCTION
  FAILED_LOGIN_ATTEMPTS 3;

CREATE ROLE DBA_USERS_PROFILE;
CREATE ROLE SYSDBA_USERS_PROFILE;

GRANT CREATE SESSION        TO DBA_USERS_PROFILE;
GRANT CREATE ANY VIEW       TO DBA_USERS_PROFILE;
GRANT CREATE ANY PROCEDURE  TO DBA_USERS_PROFILE;
GRANT CREATE ANY JOB        TO DBA_USERS_PROFILE;
GRANT CREATE ANY TABLE      TO DBA_USERS_PROFILE;
GRANT CREATE TABLESPACE     TO DBA_USERS_PROFILE;
GRANT SELECT ANY DICTIONARY TO DBA_USERS_PROFILE;
GRANT SELECT ANY DICTIONARY TO DBA_USERS_PROFILE;
GRANT DBA TO DBA_USERS_PROFILE;

GRANT SYSDBA TO SYSDBA_USERS_PROFILE;

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE='DBA'

CREATE USER DBA_MASOUD IDENTIFIED BY Please_Change_Password11 PROFILE DBA_USERS_PROFILE;

GRANT DBA_USERS_PROFILE TO DBA_MASOUD;

GRANT SYSDBA_MASOUD TO DBA_MASOUD;

