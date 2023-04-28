CREATE PROFILE ENBDBA_DBA_USERS_PROFILE LIMIT
  PASSWORD_LIFE_TIME UNLIMITED
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  PASSWORD_VERIFY_FUNCTION ORA12C_STRONG_VERIFY_FUNCTION
  --PASSWORD_VERIFY_FUNCTION VERIFY_FUNCTION_11G
  FAILED_LOGIN_ATTEMPTS 3;

CREATE ROLE ENBDBA_DBA_ROLE;

GRANT CREATE SESSION        TO ENBDBA_DBA_ROLE;
GRANT CREATE ANY VIEW       TO ENBDBA_DBA_ROLE;
GRANT CREATE ANY PROCEDURE  TO ENBDBA_DBA_ROLE;
GRANT CREATE ANY JOB        TO ENBDBA_DBA_ROLE;
GRANT CREATE ANY TABLE      TO ENBDBA_DBA_ROLE;
GRANT CREATE TABLESPACE     TO ENBDBA_DBA_ROLE;

CREATE USER DBA_HASHEMI     IDENTIFIED BY U__d0n66Va0N49RheTX0kM  PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_NOBARI      IDENTIFIED BY d__l7Q4OY5u5j8MHq4R5Vl  PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_NIKOOFAR    IDENTIFIED BY v__W6X2FEQyl980c47JvJm  PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_SOLEIMANI   IDENTIFIED BY M__qFscXT78H4Sn78r5dM5  PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_GHODS       IDENTIFIED BY m__vzn7KaEI8T34u8O03VK  PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_SHOORCHE    IDENTIFIED BY H__B8107AdDzoTGy747lFc  PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_POUYANSHAD  IDENTIFIED BY p__4hf641N5EYP9mSw5CqI  PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_SOLATI      IDENTIFIED BY q__6653XUCRKa55hS1Xohr  PROFILE ENBDBA_DBA_USERS_PROFILE;
CREATE USER DBA_GHADIMIKHOO IDENTIFIED BY q__6653XUCRKa55hS1XoWr  PROFILE ENBDBA_DBA_USERS_PROFILE;

GRANT ENBDBA_DBA_ROLE TO DBA_HASHEMI    ;
GRANT ENBDBA_DBA_ROLE TO DBA_NOBARI     ;
GRANT ENBDBA_DBA_ROLE TO DBA_NIKOOFAR   ;
GRANT ENBDBA_DBA_ROLE TO DBA_SOLEIMANI  ;
GRANT ENBDBA_DBA_ROLE TO DBA_GHODS      ;
GRANT ENBDBA_DBA_ROLE TO DBA_SHOORCHE   ;
GRANT ENBDBA_DBA_ROLE TO DBA_POUYANSHAD ;
GRANT ENBDBA_DBA_ROLE TO DBA_SOLATI     ;
GRANT ENBDBA_DBA_ROLE TO DBA_GHADIMIKHOO;

REVOKE CREATE SESSION        FROM ENBDBA_DBA_ROLE;
REVOKE CREATE ANY VIEW       FROM ENBDBA_DBA_ROLE;
REVOKE CREATE ANY PROCEDURE  FROM ENBDBA_DBA_ROLE;
REVOKE CREATE ANY JOB        FROM ENBDBA_DBA_ROLE;
REVOKE CREATE ANY TABLE      FROM ENBDBA_DBA_ROLE;
REVOKE CREATE TABLESPACE     FROM ENBDBA_DBA_ROLE;


GRANT DBA TO ENBDBA_DBA_ROLE;
REVOKE SYSDBA FROM DBA_HASHEMI     ;
REVOKE SYSDBA FROM DBA_NOBARI      ;
REVOKE SYSDBA FROM DBA_NIKOOFAR    ;
REVOKE SYSDBA FROM DBA_SOLEIMANI   ;
REVOKE SYSDBA FROM DBA_GHODS       ;
REVOKE SYSDBA FROM DBA_SHOORCHE    ;
REVOKE SYSDBA FROM DBA_POUYANSHAD  ;
REVOKE SYSDBA FROM DBA_SOLATI      ;


GRANT SYSDBA TO DBA_NIKOOFAR;
GRANT SYSDBA TO DBA_SHOORCHE;