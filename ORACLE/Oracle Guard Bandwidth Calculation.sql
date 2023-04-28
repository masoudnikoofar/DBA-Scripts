SELECT trunc(first_time) DAYS,
count(*) NUM_SWITCHES,
trunc(count(*)*log_size/1024/1024/1024) TOTAL_SIZE_IN_GB,
to_char(count(*)/24,'9999.9') AVG_SWITCHES_AN_HOUR
FROM v$loghist,
(select avg(bytes) log_size from v$log) GROUP BY trunc(first_time),log_size order by DAYS;





SELECT to_char(first_time,'yyyy/mm/dd hh24') Hour,
count(*) NUM_SWITCHES,
trunc(count(*)*log_size*8/((1024*1024)*(60*60))) TOTAL_SIZE_IN_Mb,
to_char(count(*)/24,'9999.9') AVG_SWITCHES_AN_HOUR
FROM v$loghist,
(select avg(bytes) log_size from v$log) GROUP BY to_char(first_time,'yyyy/mm/dd hh24'),log_size 
