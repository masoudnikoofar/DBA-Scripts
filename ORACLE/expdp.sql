CREATE DIRECTORY DUMPS AS '/u01/Backups';


SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;





show parameter db_create_file_dest;
select file_name from dba_data_files;
alter system set db_create_file_dest='/u01/app/oracle/oradata/encrm/';

CREATE TABLESPACE TBS_EXPDP DATAFILE SIZE 1M AUTOEXTEND ON MAXSIZE UNLIMITED;
CREATE USER ENBDBA_EXPDP IDENTIFIED BY 123 default tablespace TBS_EXPDP quota unlimited on TBS_EXPDP profile ENBDBA_DBA_USERS_PROFILE;
GRANT READ, WRITE ON DIRECTORY DUMPS TO ENBDBA_EXPDP;
GRANT DATAPUMP_EXP_FULL_DATABASE TO ENBDBA_EXPDP;

enbdba_expdp/123

SELECT DIRECTORY_PATH FROM DBA_DIRECTORIES WHERE DIRECTORY_NAME = 'DUMPS';



expdp / full=Y directory=dumps dumpfile=full.dmp logfile=full.log
expdp / full=Y directory=dumps dumpfile=mmt20150301164000.dmp logfile=mmt20150301164000.log


expdp enbdba_expdp/123 full=y compression=all encryption=all encryption_password=123 directory=dumps dumpfile=full.dmp logfile=full.log parallel=10


impdp sys as sysdba full=Y directory=dumps dumpfile=full.dmp logfile=full.log table_exists_action=???





mkstore -wrl $ORACLE_HOME/admin/wallets -create

mkstore -wrl $ORACLE_HOME/admin/wallets -createCredential ENBDB enbdba_expdp 
