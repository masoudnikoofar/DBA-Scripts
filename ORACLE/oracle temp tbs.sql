--create TABLESPACE myspace datafile '/u01/app/oracle/oradata/orcl/datafiles/myspace02.dbf' size 2G autoextend on maxsize unlimited;

CREATE TEMPORARY TABLESPACE temp02 TEMPFILE '/u02/app/oracle/oradata/orcl/TEMP/temp0202.dbf' size 10M autoextend on maxsize unlimited;
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE temp02;



CREATE BIGFILE TEMPORARY TABLESPACE TEMPTBS TEMPFILE '/u02/app/oracle/oradata/orcl/TEMPTBS01.tmp' SIZE 5M AUTOEXTEND ON maxsize unlimited;
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE TEMPTBS;

ALTER TABLESPACE temp add tempfile '/u01/app/oracle/oradata/dispatch/temp05.dbf' size 2G autoextend on maxsize unlimited;
ALTER TABLESPACE myspace add datafile '/u01/app/oracle/oradata/orcl/datafiles/myspace02.dbf' size 2G autoextend on maxsize unlimited;


DROP TABLESPACE temp02 INCLUDING CONTENTS AND DATAFILES;

DROP TABLESPACE UNDOTBS1 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;




DROP TABLESPACE temp INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;



ALTER TABLESPACE temp02 add tempfile '/u02/app/oracle/oradata/orcl/TEMP/temp0202.dbf' size 2G autoextend on maxsize unlimited;
ALTER TABLESPACE temp02 add tempfile '/u02/app/oracle/oradata/orcl/TEMP/temp0203.dbf' size 2G autoextend on maxsize unlimited;
ALTER TABLESPACE temp02 add tempfile '/u02/app/oracle/oradata/orcl/TEMP/temp0204.dbf' size 2G autoextend on maxsize unlimited;
ALTER TABLESPACE temp02 add tempfile '/u02/app/oracle/oradata/orcl/TEMP/temp0205.dbf' size 2G autoextend on maxsize unlimited;
ALTER TABLESPACE temp02 add tempfile '/u02/app/oracle/oradata/orcl/TEMP/temp0206.dbf' size 2G autoextend on maxsize unlimited;
ALTER TABLESPACE temp02 add tempfile '/u02/app/oracle/oradata/orcl/TEMP/temp0207.dbf' size 2G autoextend on maxsize unlimited;
ALTER TABLESPACE temp02 add tempfile '/u02/app/oracle/oradata/orcl/TEMP/temp0208.dbf' size 2G autoextend on maxsize unlimited;



alter tablespace temp drop datafile '/u01/app/oracle/oradata/TEMP201.tmp'



ALTER DATABASE TEMPFILE  '/u01/app/oracle/oradata/TEMP201.tmp' DROP 
     INCLUDING DATAFILES;
	 
	 
	 
ALTER TABLESPACE temp SHRINK SPACE KEEP 256M;