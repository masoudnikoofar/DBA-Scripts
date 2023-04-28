sqlplus / as sysdba @$ORACLE_HOME/rdbms/admin/utlpwdmg.sql

SELECT USERNAME,PROFILE,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE FROM DBA_USERS;

SELECT USERNAME,PROFILE,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE FROM DBA_USERS where account_status='OPEN';

SELECT * FROM DBA_PROFILES WHERE PROFILE<>'MONITORING_PROFILE' ORDER BY 2,1;

--DROP PROFILE APP_USERS_PROFILE;

CREATE PROFILE ENBDBA_APP_USERS_PROFILE LIMIT
  PASSWORD_LIFE_TIME UNLIMITED
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  PASSWORD_VERIFY_FUNCTION ORA12C_STIG_VERIFY_FUNCTION
  FAILED_LOGIN_ATTEMPTS 3;
ALTER PROFILE ENBDBA_APP_USERS_PROFILE LIMIT FAILED_LOGIN_ATTEMPTS 3;
ALTER PROFILE ENBDBA_APP_USERS_PROFILE LIMIT PASSWORD_VERIFY_FUNCTION VERIFY_FUNCTION_11G;
ALTER PROFILE ENBDBA_APP_USERS_PROFILE LIMIT PASSWORD_VERIFY_FUNCTION ORA12C_STIG_VERIFY_FUNCTION;




SELECT DISTINCT PROFILE FROM DBA_PROFILES;

--------
ALTER PROFILE ENBDBA_APP_USERS_PROFILE LIMIT PASSWORD_VERIFY_FUNCTION VERIFY_FUNCTION_11G;


CREATE PROFILE ENBDBA_DBA_USERS_PROFILE LIMIT
  PASSWORD_LIFE_TIME UNLIMITED
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  PASSWORD_VERIFY_FUNCTION ORA12C_STIG_VERIFY_FUNCTION
  FAILED_LOGIN_ATTEMPTS 3;

CREATE ROLE ENBDBA_DBA_ROLE;
CREATE ROLE ENBDBA_SYSDBA_ROLE;

GRANT CREATE SESSION        TO ENBDBA_DBA_ROLE;
GRANT CREATE ANY VIEW       TO ENBDBA_DBA_ROLE;
GRANT CREATE ANY PROCEDURE  TO ENBDBA_DBA_ROLE;
GRANT CREATE ANY JOB        TO ENBDBA_DBA_ROLE;
GRANT CREATE ANY TABLE      TO ENBDBA_DBA_ROLE;
GRANT CREATE TABLESPACE     TO ENBDBA_DBA_ROLE;
GRANT SELECT ANY DICTIONARY TO ENBDBA_DBA_ROLE;
GRANT SELECT ANY DICTIONARY TO ENBDBA_DBA_ROLE;
GRANT DBA TO ENBDBA_DBA_ROLE;
GRANT SYSDBA TO ENBDBA_SYSDBA_ROLE;

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE='DBA'

CREATE USER DBA_NOBARI      IDENTIFIED BY Please_Change_Password11 PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_NIKOOFAR    IDENTIFIED BY Please_Change_Password11 PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_SOLEIMANI   IDENTIFIED BY Please_Change_Password11 PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_POUYANSHAD  IDENTIFIED BY Please_Change_Password11 PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_SOLATI      IDENTIFIED BY Please_Change_Password11 PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_MIRZADEH    IDENTIFIED BY Please_Change_Password11 PROFILE ENBDBA_DBA_USERS_PROFILE;

GRANT ENBDBA_DBA_ROLE TO  DBA_NOBARI     ;
GRANT ENBDBA_DBA_ROLE TO  DBA_NIKOOFAR   ;
GRANT ENBDBA_DBA_ROLE TO  DBA_SOLEIMANI  ;
GRANT ENBDBA_DBA_ROLE TO  DBA_POUYANSHAD ;
GRANT ENBDBA_DBA_ROLE TO  DBA_SOLATI     ;
GRANT ENBDBA_DBA_ROLE TO  DBA_MIRZADEH   ;


GRANT ENBDBA_SYSDBA_ROLE TO DBA_NOBARI     ;
GRANT ENBDBA_SYSDBA_ROLE TO DBA_NIKOOFAR   ;
GRANT ENBDBA_SYSDBA_ROLE TO DBA_SOLEIMANI  ;
GRANT ENBDBA_SYSDBA_ROLE TO DBA_POUYANSHAD  ;



ALTER PROFILE ENBDBA_DBA_USERS_PROFILE LIMIT PASSWORD_VERIFY_FUNCTION VERIFY_FUNCTION;