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

