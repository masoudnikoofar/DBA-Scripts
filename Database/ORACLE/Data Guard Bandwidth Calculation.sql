SELECT TRUNC(FIRST_TIME) DAYS,
COUNT(*) NUM_SWITCHES,
TRUNC(COUNT(*)*LOG_SIZE/1024/1024/1024) TOTAL_SIZE_IN_GB,
TO_CHAR(COUNT(*)/24,'9999.9') AVG_SWITCHES_AN_HOUR
FROM V$LOGHIST,
(SELECT AVG(BYTES) LOG_SIZE FROM V$LOG) GROUP BY TRUNC(FIRST_TIME),LOG_SIZE ORDER BY DAYS;





SELECT TO_CHAR(FIRST_TIME,'YYYY/MM/DD HH24') HOUR,
COUNT(*) NUM_SWITCHES,
TRUNC(COUNT(*)*LOG_SIZE*8/((1024*1024)*(60*60))) TOTAL_SIZE_IN_MB,
TO_CHAR(COUNT(*)/24,'9999.9') AVG_SWITCHES_AN_HOUR
FROM V$LOGHIST,
(SELECT AVG(BYTES) LOG_SIZE FROM V$LOG) GROUP BY TO_CHAR(FIRST_TIME,'YYYY/MM/DD HH24'),LOG_SIZE 
