--Drop tablespace balance including contents;


SELECT 'CREATE TABLESPACE ' || t.username ||' DATAFILE /u01/app/oracle/oradata/orcl/datafiles/' || t.username ||'01.dbf SIZE 100M AUTOEXTEND ON MAXSIZE unlimited;'
FROM dba_users t
WHERE t.username in ('new-risk',
             'TECHNO',
             'ENBDBA',
             'BALANCE',
             'RISK',
             'PORTAL',
             'SOFTWARE',
             'KAVOSHGAR',
             'BIDM',
             'SWEN',
             'EPRD',
             'PAYMENT')





SELECT 
'ALTER USER ' || username ||' DEFAULT TABLESPACE ' || username ||';'
FROM dba_users t
WHERE username in ('new-risk',
             'TECHNO',
             'ENBDBA',
             'BALANCE',
             'RISK',
             'PORTAL',
             'SOFTWARE',
             'KAVOSHGAR',
             'BIDM',
             'SWEN',
             'EPRD',
             'PAYMENT')




 


CREATE TABLESPACE ' || OWNER ||' DATAFILE '/u01/app/oracle/oradata/dispatch/datafiles/' || OWNER ||'01.dbf' SIZE 100M AUTOEXTEND ON MAXSIZE unlimited;

ALTER TABLE BIDM.KHORDAD92 MOVE TABLESPACE  BIDM; 

	
SELECT 'ALTER TABLE ' || OWNER ||'.' || OBJECT_NAME ||' MOVE TABLESPACE '||' ' || OWNER ||'; '
FROM ALL_OBJECTS
WHERE OWNER in ('new-risk',
             'TECHNO',
             'ENBDBA',
             'BALANCE',
             'RISK',
             'PORTAL',
             'SOFTWARE',
             'KAVOSHGAR',
             'BIDM',
             'SWEN',
             'EPRD',
             'PAYMENT')
AND OBJECT_TYPE = 'TABLE'
