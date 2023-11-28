SELECT A.GROUP#, A.MEMBER,B."STATUS",B."BYTES" FROM V$LOGFILE A, V$LOG B WHERE A.GROUP# = B.GROUP# ORDER BY 1;
SELECT A.GROUP#, A.MEMBER,B."STATUS",TO_CHAR(B."BYTES") FROM V$LOGFILE A, V$LOG B WHERE A.GROUP# = B.GROUP# ORDER BY 1;

SELECT GROUP# , STATUS FROM V$LOG;
---------------------------------------------------
alter database drop logfile group 2 ;
alter database drop standby logfile group 6
---------------------------------------------------
alter system checkpoint global;
---------------------------------------------------
ALTER DATABASE ADD LOGFILE GROUP 3 ('/u01/app/oracle/oradata/orcl/redo01.log') SIZE 100M REUSE;
ALTER DATABASE ADD LOGFILE MEMBER '/oracle/oradata/CURACAO9/redo02b.log' REUSE TO GROUP 3;
---------------------------------------------------
SELECT GROUP#, STATUS FROM V$LOG;--UNUSED
---------------------------------------------------
ALTER SYSTEM SWITCH LOGFILE;
ALTER SYSTEM CHECKPOINT GLOBAL;
---------------------------------------------------
ALTER SYSTEM SET DB_CREATE_ONLINE_LOG_DEST_1 = '/u01/app/oracle/oradata/dbtest12';
ALTER SYSTEM SET DB_CREATE_ONLINE_LOG_DEST_2 = '+DATA';

ALTER DATABASE ADD LOGFILE  GROUP 2 SIZE 1G;
ALTER DATABASE ADD LOGFILE  GROUP 4 SIZE 10737418240;





