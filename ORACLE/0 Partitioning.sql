SELECT * FROM USER_PART_TABLES;

SELECT * FROM USER_TAB_PARTITIONS;
-------------------------------------------
SET LINESIZE 100

COLUMN TABLE_NAME FORMAT A30
COLUMN PARTITION_NAME FORMAT A30
COLUMN HIGH_VALUE FORMAT A15

SELECT TABLE_NAME,
       PARTITION_NAME,
       HIGH_VALUE,
       NUM_ROWS
FROM   USER_TAB_PARTITIONS
ORDER BY 1, 2;
-------------------------------------------

SELECT 
'ALTER TABLE '||TABLE_OWNER ||'."'||TABLE_NAME||'" MOVE PARTITION '||PARTITION_NAME||' TABLESPACE TABLESPACE_NAME PARALLEL(DEGREE 4) UPDATE GLOBAL INDEXES;' 
FROM 
DBA_TAB_PARTITIONS 
WHERE 
TABLESPACE_NAME = 'TABLESPACE_NAME' AND TABLE_NAME='TABLE_NAME' ORDER BY PARTITION_POSITION DESC

SELECT 'ALTER INDEX SCHEMA."' || X.INDEX_NAME || '" REBUILD PARALLEL 30;'
FROM DBA_INDEXES X WHERE X.STATUS='UNUSABLE';



CREATE TABLE SCHEMA.TABLE_NAME
(
  ....
)
PARTITION BY RANGE (COLUMN_NAME)
PARTITION P1 VALUES LESS THAN ('1389/01/02'),
PARTITION P2 VALUES LESS THAN ('1389/01/03'),
PARTITION P5 VALUES LESS THAN (MAXVALUE);

ALTER TABLE SCHEMA.TABLE_NAME ADD PARTITION 
(
	PARTITION P3 VALUES LESS THAN ('1389/01/04'),
	PARTITION P4 VALUES LESS THAN ('1389/01/05'),
	....
)
TABLESPACE TABLESPACE_NAME
-------------------------------------------
CREATE TABLE SCHEMA.TABLE_NAME
(
  ....
)
PARTITION BY RANGE (DATE_COLUMN_NAME) INTERVAL (NUMTODSINTERVAL(1, 'DAY')) (
PARTITION P_DATE_COLUMN_NAME VALUES LESS THAN (TO_DATE('1402-01-01 00:00:00', 'SYYY-MM-DD HH24:MI:SS', 
'NLS_CALENDAR=PERSIAN'));
