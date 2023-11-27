ALTER SYSTEM SET DB_CREATE_FILE_DEST='....';
----------------------------------------------------------------------------------------------------------------------------------
SELECT A.TABLESPACE_NAME,A.STATUS,A.CONTENTS,A.LOGGING,A.ENCRYPTED FROM DBA_TABLESPACES A; 
SELECT A.TABLESPACE_NAME,A.FILE_NAME,A.FILE_ID,A.BYTES,A.USER_BYTES,A.MAXBYTES,A.STATUS FROM DBA_DATA_FILES A;
----------------------------------------------------------------------------------------------------------------------------------
CREATE TABLESPACE TBS01 DATAFILE '+DATA/instance/datafile/TBS0101.DBF' SIZE 100M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE TBS01 ADD DATAFILE '+DATA/instance/datafile/TBS0102.DBF' SIZE 100M AUTOEXTEND ON MAXSIZE UNLIMITED;
----------------------------------------------------------------------------------------------------------------------------------
DROP TABLESPACE TBS01 INCLUDING CONTENTS AND DATAFILES;
----------------------------------------------------------------------------------------------------------------------------------
SELECT A.USERNAME,A.DEFAULT_TABLESPACE,A.TEMPORARY_TABLESPACE FROM DBA_USERS A;
SELECT A.TABLESPACE_NAME,A.USERNAME,A.BYTES,A.MAX_BYTES FROM DBA_TS_QUOTAS A;
ALTER USER USER01 QUOTA 4G ON TBS01;
ALTER USER USER01 QUOTA UNLIMITED ON TBS01;
----------------------------------------------------------------------------------------------------------------------------------
CREATE TEMPORARY TABLESPACE TEMP02 TEMPFILE '+DATA/instance/datafile/TEMP0201.dbf' SIZE 10M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE TEMP02 ADD TEMPFILE '+DATA/instance/datafile/TEMP0202.dbf' SIZE 2G AUTOEXTEND ON MAXSIZE UNLIMITED;
----------------------------------------------------------------------------------------------------------------------------------
ALTER DATABASE DEFAULT TABLESPACE TBS01;
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE TEMP02;
SELECT * FROM DATABASE_PROPERTIES A WHERE A.PROPERTY_NAME LIKE '%TABLESPACE%';
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLESPACE TEMP02 SHRINK SPACE KEEP 256M;
----------------------------------------------------------------------------------------------------------------------------------
CREATE UNDO TABLESPACE UNDOTBS2 DATAFILE '+DATA/instance/datafile/UNDOTBS201.dbf' SIZE 200M REUSE AUTOEXTEND ON;
ALTER TABLESPACE UNDOTBS2 ADD DATAFILE '+DATA/instance/datafile/UNDOTBS202.dbf' SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
DROP TABLESPACE UNDOTBS2 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
SHOW PARAMETER UNDO_TABLESPACE;
ALTER SYSTEM SET UNDO_TABLESPACE=UNDOTBS2;
----------------------------------------------------------------------------------------------------------------------------------
SELECT 'ALTER TABLE ' || OWNER || '.' || TABLE_NAME || ' ENABLE ROW MOVEMENT;' FROM DBA_TABLES X WHERE X.TABLESPACE_NAME='TBS_NAME';
SELECT 'ALTER TABLE ' || OWNER || '.' || TABLE_NAME || ' SHRINK SPACE;' FROM DBA_TABLES X WHERE X.TABLESPACE_NAME='TBS_NAME';
SELECT 'ALTER TABLE ' || OWNER || '.' || TABLE_NAME || ' DISABLE ROW MOVEMENT;' FROM DBA_TABLES X WHERE X.TABLESPACE_NAME='TBS_NAME';
PURGE DBA_RECYCLEBIN;

