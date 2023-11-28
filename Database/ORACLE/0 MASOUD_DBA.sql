CREATE USER MASOUD_DBA IDENTIFIED BY 12;
GRANT DBA TO MASOUD_DBA;
GRANT SYSDBA TO MASOUD_DBA;
-------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_ACTIVE_SQL AS
SELECT DISTINCT 
                S.USERNAME,
				S.LAST_CALL_ET SES_ACTIVE_TIME,
                S.SECONDS_IN_WAIT TIME_WAIT,
                S.SID,
                S.SERIAL#,
                T.SQL_TEXT,
                S.SQL_ID,
                S.EVENT,
                S.MACHINE,
                S.MODULE,
                S.OSUSER,
                S.PREV_SQL_ID,
                S.SERVICE_NAME,
                S.ROW_WAIT_OBJ#,
                S.P1TEXT||':  '||S.P1 P1_INFO,
                S.P2TEXT||':  '||S.P2 P2_INFO,
                S.P3TEXT||':  '||S.P3 P3_INFO,
                'EXEC KWP_UTILITY.SIMPLE_KILL( ' || S.SID || ',' || S.SERIAL# || ');' KILL_UTILITY,
                'ALTER SYSTEM KILL SESSION ''' || S.SID || ',' || S.SERIAL# || ''' IMMEDIATE;' KILL_COMAND,
                 S.BLOCKING_SESSION,
                S.BLOCKING_INSTANCE,
                S.SQL_EXEC_START,
                S.WAIT_TIME_MICRO,
                S.TIME_REMAINING_MICRO,
                S.TIME_SINCE_LAST_WAIT_MICRO,
                S.SERVER
  FROM V$SQL T, V$SESSION S
 WHERE S.SQL_ID = T.SQL_ID(+)
   --AND S.WAIT_CLASS <> 'IDLE'
   AND S.STATUS = 'ACTIVE'
   AND S.TYPE <> 'BACKGROUND' ORDER BY SES_ACTIVE_TIME DESC
  -- AND S.USERNAME <> 'SYS'
  ;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_ASH AS
SELECT T.PROGRAM,T.MODULE, T.SESSION_ID,Y.USERNAME,X.SQL_TEXT,TO_CHAR(T.SQL_EXEC_START,'YYYY/MM/DD HH24:MI:SS','NLS_CALENDAR=PERSIAN') AS SQL_EXEC_START FROM DBA_HIST_ACTIVE_SESS_HISTORY T LEFT JOIN V$SQL X
ON X.SQL_ID=T.SQL_ID
LEFT JOIN DBA_USERS Y
ON T.USER_ID=Y.USER_ID
ORDER BY T.SQL_EXEC_START;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_ASH2 AS
SELECT T.PROGRAM,T.MODULE, T.SESSION_ID,Y.USERNAME,X.SQL_TEXT,TO_CHAR(T.SQL_EXEC_START,'YYYY/MM/DD HH24:MI:SS','NLS_CALENDAR=PERSIAN') AS SQL_EXEC_START FROM V$ACTIVE_SESSION_HISTORY T LEFT JOIN V$SQL X
ON X.SQL_ID=T.SQL_ID
LEFT JOIN DBA_USERS Y
ON T.USER_ID=Y.USER_ID
ORDER BY T.SQL_EXEC_START;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_PROCESS AS
SELECT 'PROCESS' AS NAME,COUNT(*) AS COUNT FROM V$PROCESS T
UNION
SELECT  'BACKGROUND PROCESS' AS NAME,COUNT(*) AS COUNT FROM V$BGPROCESS T;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_RMAN AS
SELECT OPERATION, STATUS, MBYTES_PROCESSED, START_TIME, END_TIME FROM
V$RMAN_STATUS;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_RMAN_PROGRESS AS
SELECT OPNAME, SID, SERIAL#, CONTEXT, SOFAR, TOTALWORK,
       ROUND(SOFAR/TOTALWORK*100,2) "% COMPLETE"
       FROM V$SESSION_LONGOPS
       WHERE OPNAME LIKE 'RMAN%' AND OPNAME NOT LIKE '%AGGREGATE%'
       AND TOTALWORK != 0 AND SOFAR <> TOTALWORK;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_RUNNING_JOBS AS
SELECT OWNER , JOB_NAME , RUNNING_INSTANCE, SESSION_ID FROM ALL_SCHEDULER_RUNNING_JOBS
ORDER BY OWNER , JOB_NAME;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW SYS.MASOUD_DBA_SEGMENTS AS
SELECT X.OWNER,SUM(X.BYTES)/1024/1024/1024 AS GBYTES FROM DBA_SEGMENTS X 
GROUP BY X.OWNER
ORDER BY 2 DESC;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_SESSION AS
SELECT P.SPID,
       S.USERNAME,
       S.PROGRAM,
       Y.SQL_TEXT,
       Y.SQL_FULLTEXT,
       (CASE
     WHEN TRUNC(Y.ELAPSED_TIME/1000000)<60 THEN TO_CHAR(TRUNC(Y.ELAPSED_TIME/1000000))||' SEC(S)'
     WHEN TRUNC(Y.ELAPSED_TIME/1000000/60)<60 THEN TO_CHAR(TRUNC(Y.ELAPSED_TIME/1000000/60))||' MIN(S)'
     WHEN TRUNC(Y.ELAPSED_TIME/1000000/60/60)<24 THEN TO_CHAR(TRUNC(Y.ELAPSED_TIME/1000000/60/60))||'
HOUR(S)'
     WHEN TRUNC(Y.ELAPSED_TIME/1000000/60/60/24)>=1  THEN
TO_CHAR(TRUNC(Y.ELAPSED_TIME/1000000/60/60/24))||' DAY(S)'
 END) AS TIME,
       S.MACHINE || '(' || S.OSUSER || ')' AS OSUSER,
       'ALTER SYSTEM KILL SESSION ''' || S.SID || ',' || S.SERIAL# ||''' IMMEDIATE;' KILL_COMMAND
  FROM GV$SESSION S
  JOIN GV$PROCESS P
    ON P.ADDR = S.PADDR
  JOIN GV$SQL Y
  ON S.SQL_ID=Y.SQL_ID
   AND P.INST_ID = S.INST_ID
   AND S.STATUS = 'ACTIVE'
   AND S.USERNAME IS NOT NULL
   ORDER BY S.USERNAME;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_SESSION2 AS
SELECT A.STATUS, COUNT (1) AS TOTAL, INST_ID
       FROM GV$SESSION A
      WHERE A.USERNAME IS NOT NULL
   GROUP BY A.STATUS, INST_ID
   ORDER BY 1;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW SYS.MASOUD_DBA_TABLESPACES AS
SELECT T.TABLESPACE_NAME AS TABLESPACE,
       T.STATUS AS STATUS,
       ROUND(MAX(D.BYTES) / 1024 / 1024, 2) AS TOTAL,
       ROUND((MAX(D.BYTES) / 1024 / 1024) -
             (SUM(DECODE(F.BYTES, NULL, 0, F.BYTES)) / 1024 / 1024),
             2) AS USED,
       ROUND(100 * (ROUND((MAX(D.BYTES) / 1024 / 1024) -
                          (SUM(DECODE(F.BYTES, NULL, 0, F.BYTES)) / 1024 / 1024),
                          2)) / ROUND(MAX(D.BYTES) / 1024 / 1024, 2)) AS USED_P,
       ROUND(SUM(DECODE(F.BYTES, NULL, 0, F.BYTES)) / 1024 / 1024, 2) AS FREE,
       ROUND(100 *
             (1 - (ROUND((MAX(D.BYTES) / 1024 / 1024) -
                         (SUM(DECODE(F.BYTES, NULL, 0, F.BYTES)) / 1024 / 1024),
                         2)) / ROUND(MAX(D.BYTES) / 1024 / 1024, 2))) AS FREE_P,
       ROUND(((MAX(D.BYTES) -(SUM(DECODE(F.BYTES, NULL, 0, F.BYTES))))/ (1024 * 1024 * 1024 * 32)) * 100) AS  REAL_USED_P,
       T.PCT_INCREASE AS INCREASE_P,
       SUBSTR(D.FILE_NAME, 1, 80) AS FILE_NAME,
       T.BIGFILE AS BIGFILE
  FROM DBA_FREE_SPACE F, DBA_DATA_FILES D, DBA_TABLESPACES T
 WHERE T.TABLESPACE_NAME = D.TABLESPACE_NAME
   AND F.TABLESPACE_NAME(+) = D.TABLESPACE_NAME
   AND F.FILE_ID(+) = D.FILE_ID
 GROUP BY T.TABLESPACE_NAME, D.FILE_NAME, T.PCT_INCREASE, T.STATUS,T.BIGFILE
 ORDER BY 3 DESC, 4 DESC;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_TABLE_LOCK AS
SELECT A.SESSION_ID,
       A.ORACLE_USERNAME,
       A.OS_USER_NAME,
       B.OWNER "OBJECT OWNER",
       B.OBJECT_NAME,
       B.OBJECT_TYPE,
       A.LOCKED_MODE
  FROM (SELECT OBJECT_ID,
               SESSION_ID,
               ORACLE_USERNAME,
               OS_USER_NAME,
               LOCKED_MODE
          FROM V$LOCKED_OBJECT) A,
       (SELECT OBJECT_ID, OWNER, OBJECT_NAME, OBJECT_TYPE FROM DBA_OBJECTS) B
 WHERE A.OBJECT_ID = B.OBJECT_ID;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_TABLE_LOCK2 AS
SELECT T2.USERNAME,
T2.SID,
T2.SERIAL#,
T3.OBJECT_NAME,
T2.OSUSER,
T2.MACHINE,
T2.PROGRAM,
T2.LOGON_TIME,
T2.COMMAND,
T2.LOCKWAIT,
T2.SADDR,
T2.PADDR,
T2.TADDR,
T2.SQL_ADDRESS,
T1.LOCKED_MODE
FROM V$LOCKED_OBJECT T1, V$SESSION T2, DBA_OBJECTS T3
WHERE T1.SESSION_ID = T2.SID
AND T1.OBJECT_ID = T3.OBJECT_ID
ORDER BY T2.LOGON_TIME;


-----------------
CREATE OR REPLACE VIEW MASOUD_DBA_RUN_JOB_DETAILS AS
SELECT 
X.OWNER,X.JOB_NAME,X.STATUS,TO_CHAR(X.REQ_START_DATE,'YYYY-MM-DD HH24:MI:SS','NLS_CALENDAR=PERSIAN') AS REQ_START_DATE,X.ADDITIONAL_INFO
 FROM DBA_SCHEDULER_JOB_RUN_DETAILS X
 ORDER BY 3 DESC;

-----------------


CREATE OR REPLACE VIEW MASOUD_DBA_FAILED_LOGINS AS
SELECT USERID,
USERHOST,
DECODE(RETURNCODE,01017,'LOGIN ERROR','ACOUNT LOCKED') "ISSUE",
SPARE1,
TO_CHAR ( CAST(
( FROM_TZ(
CAST(
TO_DATE(
TO_CHAR( NTIMESTAMP# , 'DD/MM/YYYY HH:MI PM'),
'DD/MM/YYYY HH:MI PM'
)
AS TIMESTAMP
) ,
'GMT'
) AT LOCAL
)
AS TIMESTAMP)
, 'DD/MM/YYYY HH:MI PM') "TIME",
SQLTEXT,
COMMENT$TEXT FROM SYS.AUD$
WHERE ( RETURNCODE=1017 OR RETURNCODE=28000 )
ORDER BY NTIMESTAMP# DESC ;

-----------------
CREATE OR REPLACE VIEW MASOUD_DBA_TEMP_USAGE AS
SELECT P.SPID,
       S.USERNAME,
       S.PROGRAM,
       Y.SQL_TEXT,
       Z.TABLESPACE,
       (CASE
     WHEN TRUNC(Y.ELAPSED_TIME/1000000)<60 THEN TO_CHAR(TRUNC(Y.ELAPSED_TIME/1000000))||' SEC(S)'
     WHEN TRUNC(Y.ELAPSED_TIME/1000000/60)<60 THEN TO_CHAR(TRUNC(Y.ELAPSED_TIME/1000000/60))||' MIN(S)'
     WHEN TRUNC(Y.ELAPSED_TIME/1000000/60/60)<24 THEN TO_CHAR(TRUNC(Y.ELAPSED_TIME/1000000/60/60))||'
HOUR(S)'
     WHEN TRUNC(Y.ELAPSED_TIME/1000000/60/60/24)>=1  THEN
TO_CHAR(TRUNC(Y.ELAPSED_TIME/1000000/60/60/24))||' DAY(S)'
 END) AS TIME,
       S.MACHINE || '(' || S.OSUSER || ')' AS OSUSER,
       'ALTER SYSTEM KILL SESSION ''' || S.SID || ',' || S.SERIAL# ||''' IMMEDIATE;' KILL_COMMAND
  FROM GV$SESSION S
  LEFT JOIN GV$PROCESS P
    ON P.ADDR = S.PADDR
  LEFT JOIN GV$SQL Y
  ON S.SQL_ID=Y.SQL_ID
   AND P.INST_ID = S.INST_ID
--   AND S.STATUS = 'ACTIVE'
   AND S.USERNAME IS NOT NULL
  RIGHT JOIN V$SORT_USAGE Z
  ON Z.SESSION_ADDR=S.SADDR
   ORDER BY S.USERNAME;
---------------------------------
CREATE OR REPLACE VIEW SYS.MASOUD_DBA_DATAFILE_RESIZE AS
WITH
 HWM AS (
  -- GET HIGHEST BLOCK ID FROM EACH DATAFILES ( FROM X$KTFBUE AS WE DON'T NEED ALL JOINS FROM DBA_EXTENTS )
  SELECT /*+ MATERIALIZE */ KTFBUESEGTSN TS#,KTFBUEFNO RELATIVE_FNO,MAX(KTFBUEBNO+KTFBUEBLKS-1) HWM_BLOCKS
  FROM SYS.X$KTFBUE GROUP BY KTFBUEFNO,KTFBUESEGTSN
 ),
 HWMTS AS (
  -- JOIN TS# WITH TABLESPACE_NAME
  SELECT NAME TABLESPACE_NAME,RELATIVE_FNO,HWM_BLOCKS
  FROM HWM JOIN V$TABLESPACE USING(TS#)
 ),
 HWMDF AS (
  -- JOIN WITH DATAFILES, PUT 5M MINIMUM FOR DATAFILES WITH NO EXTENTS
  SELECT FILE_NAME,NVL(HWM_BLOCKS*(BYTES/BLOCKS),5*1024*1024) HWM_BYTES,BYTES,AUTOEXTENSIBLE,MAXBYTES
  FROM HWMTS RIGHT JOIN DBA_DATA_FILES USING(TABLESPACE_NAME,RELATIVE_FNO)
 )
SELECT
 CASE WHEN AUTOEXTENSIBLE='YES' AND MAXBYTES>=BYTES
 THEN -- WE GENERATE RESIZE STATEMENTS ONLY IF AUTOEXTENSIBLE CAN GROW BACK TO CURRENT SIZE
  '/* RECLAIM '||TO_CHAR(CEIL((BYTES-HWM_BYTES)/1024/1024),999999)
   ||'M FROM '||TO_CHAR(CEIL(BYTES/1024/1024),999999)||'M */ '
   ||'ALTER DATABASE DATAFILE '''||FILE_NAME||''' RESIZE '||CEIL(HWM_BYTES/1024/1024)||'M;'
 ELSE -- GENERATE ONLY A COMMENT WHEN AUTOEXTENSIBLE IS OFF
  '/* RECLAIM '||TO_CHAR(CEIL((BYTES-HWM_BYTES)/1024/1024),999999)
   ||'M FROM '||TO_CHAR(CEIL(BYTES/1024/1024),999999)
   ||'M AFTER SETTING AUTOEXTENSIBLE MAXSIZE HIGHER THAN CURRENT SIZE FOR FILE '
   || FILE_NAME||' */'
 END SQL
FROM HWMDF
WHERE
 BYTES-HWM_BYTES>1024*1024 -- RESIZE ONLY IF AT LEAST 1MB CAN BE RECLAIMED
ORDER BY BYTES-HWM_BYTES DESC;

------------------
CREATE OR REPLACE VIEW SYS.MASOUD_DBA_AUDIT_EXPORT AS
SELECT
'EXP SYSTEM/INVALID TABLES=''SYS.' || X.TABLE_NAME || ''' FILE='|| X.TABLE_NAME ||'.DMP LOG='|| X.TABLE_NAME || '.LOG  &' AS COMMAND

 FROM DBA_TABLES X WHERE X.TABLE_NAME LIKE 'AUD_13%';
 
----------------------
CREATE OR REPLACE VIEW SYS.MASOUD_DBA_DATAFILE_RESIZE AS
WITH
 HWM AS (
  -- GET HIGHEST BLOCK ID FROM EACH DATAFILES ( FROM X$KTFBUE AS WE DON'T NEED ALL JOINS FROM DBA_EXTENTS )
  SELECT /*+ MATERIALIZE */ KTFBUESEGTSN TS#,KTFBUEFNO RELATIVE_FNO,MAX(KTFBUEBNO+KTFBUEBLKS-1) HWM_BLOCKS
  FROM SYS.X$KTFBUE GROUP BY KTFBUEFNO,KTFBUESEGTSN
 ),
 HWMTS AS (
  -- JOIN TS# WITH TABLESPACE_NAME
  SELECT NAME TABLESPACE_NAME,RELATIVE_FNO,HWM_BLOCKS
  FROM HWM JOIN V$TABLESPACE USING(TS#)
 ),
 HWMDF AS (
  -- JOIN WITH DATAFILES, PUT 5M MINIMUM FOR DATAFILES WITH NO EXTENTS
  SELECT FILE_NAME,NVL(HWM_BLOCKS*(BYTES/BLOCKS),5*1024*1024) HWM_BYTES,BYTES,AUTOEXTENSIBLE,MAXBYTES
  FROM HWMTS RIGHT JOIN DBA_DATA_FILES USING(TABLESPACE_NAME,RELATIVE_FNO)
 )
SELECT
 CASE WHEN AUTOEXTENSIBLE='YES' AND MAXBYTES>=BYTES
 THEN -- WE GENERATE RESIZE STATEMENTS ONLY IF AUTOEXTENSIBLE CAN GROW BACK TO CURRENT SIZE
  '/* RECLAIM '||TO_CHAR(CEIL((BYTES-HWM_BYTES)/1024/1024),999999)
   ||'M FROM '||TO_CHAR(CEIL(BYTES/1024/1024),999999)||'M */ '
   ||'ALTER DATABASE DATAFILE '''||FILE_NAME||''' RESIZE '||CEIL(HWM_BYTES/1024/1024)||'M;'
 ELSE -- GENERATE ONLY A COMMENT WHEN AUTOEXTENSIBLE IS OFF
  '/* RECLAIM '||TO_CHAR(CEIL((BYTES-HWM_BYTES)/1024/1024),999999)
   ||'M FROM '||TO_CHAR(CEIL(BYTES/1024/1024),999999)
   ||'M AFTER SETTING AUTOEXTENSIBLE MAXSIZE HIGHER THAN CURRENT SIZE FOR FILE '
   || FILE_NAME||' */'
 END SQL
FROM HWMDF
WHERE
 BYTES-HWM_BYTES>1024*1024 -- RESIZE ONLY IF AT LEAST 1MB CAN BE RECLAIMED
ORDER BY BYTES-HWM_BYTES DESC;
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MASOUD_DBA_TRANSACTIONS AS
SELECT A.USERNAME,B.SQL_TEXT,C.XIDUSN || '.' || C.XIDSLOT || '.' || C.XIDSQN AS TRANS_ID
 FROM V$SESSION A,V$SQL B,V$TRANSACTION C
WHERE A.SQL_ID=B.SQL_ID AND A.TADDR=C.ADDR
--AND (C.XIDUSN || '.' || C.XIDSLOT || '.' || C.XIDSQN) IN (('35.13.47074'))
ORDER BY 1
--SELECT X.* FROM V$TRANSACTION X --WHERE (X.XIDUSN || '.' || X.XIDSLOT || '.' || X.XIDSQN) IN ('34.24.66947')
;


CREATE OR REPLACE VIEW SYS.MASOUD_DBA_ASM_DISKGROUP AS
SELECT NAME,STATE,TOTAL_MB,FREE_MB FROM V$ASM_DISKGROUP;


CREATE OR REPLACE VIEW SYS.MASOUD_DBA_IMPORT_PROGRESS AS
SELECT
B.USERNAME,A.SID,B.OPNAME,B.TARGET,ROUND(B.SOFAR*100/B.TOTALWORK,0) || '%' AS DONE_PERCENTAGE,B.TIME_REMAINING,TO_CHAR(B.START_TIME,'YYYY/MM/DD HH24:MI:SS','NLS_CALENDAR=PERSIAN') AS START_TIME,B.SOFAR,B.TOTALWORK
FROM V$SESSION_LONGOPS B,V$SESSION A
WHERE A.SID=B.SID
ORDER BY 6;


CREATE OR REPLACE VIEW SYS.MASOUD_DBA_TOP_QUERIES_ELAPSED_TIME AS
SELECT B.USERNAME,
       A.SQL_TEXT,
       A.SQL_FULLTEXT,
       A.SQL_ID,
       A.ELAPSED_TIME / 1000 / 1000 AS ELAPSED_TIME_SECONDS,
       A.CHILD_NUMBER,
       A.DISK_READS,
       A.EXECUTIONS,
       A.FIRST_LOAD_TIME,
       A.LAST_LOAD_TIME
  FROM V$SQL A, V$SESSION B
 WHERE A.SQL_ID = B.SQL_ID
 ORDER BY ELAPSED_TIME DESC