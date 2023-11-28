set lines 10000
col group# format a25;
col value format a20;
col time_computed format a20;



select process,status,group#,thread#,sequence#
from v$managed_standby
order by process,group#,thread#,sequence#;



col name format a25;
col value format a20;
col time_computed format a20;

select name,value,time_computed from v$dataguard_stats;

SELECT ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Last in Sequence", APPL.SEQUENCE# "Last Applied Sequence", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Difference"
FROM
(SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#)) ARCH,
(SELECT THREAD# ,SEQUENCE# FROM V$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$LOG_HISTORY GROUP BY THREAD#)) APPL
WHERE
ARCH.THREAD# = APPL.THREAD#
ORDER BY 1;




--------GAP 
SELECT THREAD#, LOW_SEQUENCE#, HIGH_SEQUENCE# FROM V$ARCHIVE_GAP;


--approximate completion time of the recovery process
select to_char(start_time,'DD-MON-RR HH24:MI:SS') start_time,item,round(sofar/1024,2) "MB/Sec" from v$recovery_progress 
where (item='Active Apply Rate' or item='Average Apply Rate');