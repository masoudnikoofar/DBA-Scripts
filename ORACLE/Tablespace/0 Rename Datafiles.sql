------1. DATABASE
STARTUP MOUNT;
SELECT X.FILE#,NAME FROM V$DATAFILE X;

------2. OS
mv /u01/datafiles/datafile01.dbf /u01/datafiles2/datafile01.dbf

------3. DATABASE
ALTER DATABASE RENAME FILE '/u01/datafiles/datafile01.dbf' to '/u01/datafiles2/datafile01.dbf';

ALTER DATABASE OPEN;
