ALTER system SET audit_sys_operations=TRUE scope=spfile;

ALTER system SET audit_trail=db_extended scope=spfile;

startup force;

SHOW parameter audit;


BEGIN
  DBMS_AUDIT_MGMT.INIT_CLEANUP(
    AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
    DEFAULT_CLEANUP_INTERVAL => 240 /*hours*/
  );
END;
/

commit;

CREATE tablespace audit_data datafile '/u01/app/oracle/oradata/enbdb/datafiles/audit_data01.dbf'
SIZE 100M autoextend ON NEXT 50M maxsize unlimited;

alter tablespace audit_data add datafile '/u01/app/oracle/oradata/enbdb/datafiles/audit_data02.dbf'
SIZE 100M autoextend ON NEXT 50M maxsize unlimited;


BEGIN
  DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(
    AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
    AUDIT_TRAIL_LOCATION_VALUE => 'AUDIT_DATA'
  );
END;
/

commit;

SELECT PARAMETER_NAME, PARAMETER_VALUE, AUDIT_TRAIL
FROM DBA_AUDIT_MGMT_CONFIG_PARAMS
WHERE audit_trail = 'STANDARD AUDIT TRAIL';
SELECT owner,segment_name,tablespace_name FROM dba_segments WHERE segment_name ='AUD$';


$ORACLE_HOME/rdbms/admin/secconf.sql


SELECT  * FROM DBA_STMT_AUDIT_OPTS;

SELECT * FROM DBA_PRIV_AUDIT_OPTS;
 SELECT * FROM DBA_OBJ_AUDIT_OPTS;
  SELECT * FROM ALL_DEF_AUDIT_OPTS;
  
select to_char(x.last_archive_ts,'yyyymmdd hh24miss','nls_calendar=persian') from dba_audit_mgmt_last_arch_ts x  



create table sys.AUD_13930726 as select * from sys.AUD$ x where x.ntimestamp# between to_date('13930726','yyyymmdd','nls_calendar=persian') and to_date('13930727','yyyymmdd','nls_calendar=persian');
create table sys.AUD_13930727 as select * from sys.AUD$ x where x.ntimestamp# between to_date('13930727','yyyymmdd','nls_calendar=persian') and to_date('13930728','yyyymmdd','nls_calendar=persian');





NLS_LANG=American_america.AL32UTF8
export NLS_LANG

exp system/mahmoodraissi tables='sys.AUD_13930726'   file=AUD_13930726.dmp log=AUD_13930726.log  &
exp system/mahmoodraissi tables='sys.AUD_13930727'   file=AUD_13930727.dmp log=AUD_13930727.log  &


begin
DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(
   audit_trail_type  =>   DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
   last_archive_time  => to_date('13930710 070100','yyyymmdd hh24miss','nls_calendar=persian')
   );
   end;
  /
begin
  DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(audit_trail_type  => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
                                             last_archive_time => to_date('20141001 190000',
                                                                          'yyyymmdd hh24miss'));
end;


  
BEGIN
  DBMS_AUDIT_MGMT.clean_audit_trail(audit_trail_type        => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
                                    use_last_arch_timestamp => TRUE);
END;

  
  
  
  
  
  
  
  
  
--------------
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name   => 'DAILY_AUDIT_ARCHIVE_TIMESTAMP',
    job_type   => 'PLSQL_BLOCK',
    job_action => 'BEGIN DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(AUDIT_TRAIL_TYPE =>
                   DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,LAST_ARCHIVE_TIME => sysdate-10); END;',
    start_date => sysdate,
    repeat_interval => 'FREQ=HOURLY;INTERVAL=24',
    enabled    =>  TRUE,
    comments   => 'Create an archive timestamp'
  );
END;
/


BEGIN
  DBMS_AUDIT_MGMT.CREATE_PURGE_JOB(
    AUDIT_TRAIL_TYPE           => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
    AUDIT_TRAIL_PURGE_INTERVAL => 24 /* hours */,
    AUDIT_TRAIL_PURGE_NAME     => 'Daily_Audit_Purge_Job',
    USE_LAST_ARCH_TIMESTAMP    => TRUE
  );
END;
/

commit;



 SELECT JOB_NAME,JOB_STATUS,AUDIT_TRAIL,JOB_FREQUENCY FROM DBA_AUDIT_MGMT_CLEANUP_JOBS;



 SELECT job_name, next_run_date, state, enabled FROM dba_scheduler_jobs WHERE job_name LIKE '%AUDIT%'; 
  
  