-- Oracle SQL query over the view that shows database state:
select * from v$instance

-- Oracle SQL query that shows if database is opened
select status from v$instance

-- Oracle SQL query over the view that show Oracle database general parameters
select * from v$system_parameter

-- Oracle SQL query to know Oracle version
select value from v$system_parameter where name = 'compatible'

-- Oracle SQL query to know the path and name of spfile
select value from v$system_parameter where name = 'spfile'

-- Oracle SQL query to know the localization and number of control files
select value from v$system_parameter where name = 'control_files'

-- Oracle SQL query to show the database name.
select value from v$system_parameter where name = 'db_name'

-- Oracle SQL query over the view that shows actual Oracle conections. 
-- To use it the user need administrator privileges.
select osuser, username, machine, program
from v$session
order by osuser

-- Oracle SQL query that show the opened conections group by the program that opens the connection.
select program Aplicacion, count(program) Numero_Sesiones
from v$session
group by program
order by Numero_Sesiones desc

-- Oracle SQL query that shows Oracle users connected and the sessions number for user
select username Usuario_Oracle, count(username) Numero_Sesiones
from v$session
group by username
order by Numero_Sesiones desc

-- Objects owners number of objects for owner
select owner, count(owner) Numero
from dba_objects
group by owner
order by Numero desc

-- Oracle SQL query over the data Dictionary (includes all views and tables of the database)
select * from dictionary

-- Oracle SQL query that shows definition data from a specific table 
-- (in this case, all tables with string "XXX")
select * from ALL_ALL_TABLES where upper(table_name) like '%XXX%'

-- Oracle SQL query to know tables from actual user
select * from user_tables

-- Oracle SQL query to know all the objects of the connected user
select * from user_catalog

-- Oracle SQL query for Oracle DBA that shows tablespaces, disk used, free space and datafiles:
SELECT t.tablespace_name "Tablespace", t.status "Status",
       ROUND(MAX(d.bytes)/1024/1024,2) "Total (MB)",
       ROUND((MAX(d.bytes)/1024/1024) -
       (SUM(decode(f.bytes, NULL,0, f.bytes))/1024/1024),2) "Used (MB)",
       ROUND(SUM(decode(f.bytes, NULL,0, f.bytes))/1024/1024,2) "Free (MB)",
       t.pct_increase "% increace",
       SUBSTR(d.file_name,1,80) "File Name"
FROM DBA_FREE_SPACE f, DBA_DATA_FILES d, DBA_TABLESPACES t
WHERE t.tablespace_name = d.tablespace_name AND
      f.tablespace_name(+) = d.tablespace_name
      AND f.file_id(+) = d.file_id GROUP BY t.tablespace_name,
      d.file_name, t.pct_increase, t.status ORDER BY 1,3 DESC

-- Oracle SQL query to know Oracle products installed and version number.
select * from product_component_version

-- Oracle SQL query to know roles and roles privileges
select * from role_sys_privs

-- Oracle SQL query to know integrity rules
select constraint_name, column_name from sys.all_cons_columns

-- Oracle SQL query to know tables owned by a user, in this case "xxx":
SELECT table_owner, table_name from sys.all_synonyms where table_owner like 'xxx'

-- Oracle SQL query for the same as last query

SELECT DISTINCT TABLE_NAME
FROM ALL_ALL_TABLES
WHERE OWNER LIKE 'HR'
-- Oracle parameters, actual value and its description.
SELECT v.name, v.value value, decode(ISSYS_MODIFIABLE, 'DEFERRED',
'TRUE', 'FALSE') ISSYS_MODIFIABLE, decode(v.isDefault, 'TRUE', 'YES',
'FALSE', 'NO') "DEFAULT", DECODE(ISSES_MODIFIABLE, 'IMMEDIATE',
'YES','FALSE', 'NO', 'DEFERRED', 'NO', 'YES') SES_MODIFIABLE,
DECODE(ISSYS_MODIFIABLE, 'IMMEDIATE', 'YES', 'FALSE', 'NO',
'DEFERRED', 'YES','YES') SYS_MODIFIABLE , v.description
FROM V$PARAMETER v
WHERE name not like 'nls%' ORDER BY 1

-- Oracle SQL query that shows Oracle users and his data
Select * FROM dba_users

-- Oracle SQL query to know tablespaces and its owner:
select owner, decode(partition_name, null, segment_name,
segment_name || ':' || partition_name) name,
segment_type, tablespace_name,bytes,initial_extent,
next_extent, PCT_INCREASE, extents, max_extents
from dba_segments
Where 1=1 And extents > 1 order by 9 desc, 3

-- Last SQL queries executed on Oracle and user:
select distinct vs.sql_text, vs.sharable_mem,
vs.persistent_mem, vs.runtime_mem, vs.sorts,
vs.executions, vs.parse_calls, vs.module,
vs.buffer_gets, vs.disk_reads, vs.version_count,
vs.users_opening, vs.loads,
to_char(to_date(vs.first_load_time,
'YYYY-MM-DD/HH24:MI:SS'),'MM/DD HH24:MI:SS') first_load_time,
rawtohex(vs.address) address, vs.hash_value hash_value ,
rows_processed , vs.command_type, vs.parsing_user_id ,
OPTIMIZER_MODE , au.USERNAME parseuser
from v$sqlarea vs , all_users au
where (parsing_user_id != 0) AND
(au.user_id(+)=vs.parsing_user_id)
and (executions >= 1) order by buffer_gets/executions desc

-- Oracle SQL query to know all the tablespaces:
select * from V$TABLESPACE

-- Oracle SQL query to know free and used Shared_Pool
select name,to_number(value) bytes
from v$parameter where name ='shared_pool_size'
union all
select name,bytes
from v$sgastat where pool = 'shared pool' and name = 'free memory'
Cursores abiertos por usuario
select b.sid, a.username, b.value Cursores_Abiertos
from v$session a,
v$sesstat b,
v$statname c
where c.name in ('opened cursors current')
and b.statistic# = c.statistic#
and a.sid = b.sid
and a.username is not null
and b.value >0
order by 3

-- Oracle SQL query to know cache hits (it must be more than 1%)
select sum(pins) Ejecuciones, sum(reloads) Fallos_cache,
trunc(sum(reloads)/sum(pins)*100,2) Porcentaje_aciertos
from v$librarycache
where namespace in ('TABLE/PROCEDURE','SQL AREA','BODY','TRIGGER');

-- Complete SQL queries executed with a specific text in SQL sentence.
SELECT c.sid, d.piece, c.serial#, c.username, d.sql_text
FROM v$session c, v$sqltext d
WHERE c.sql_hash_value = d.hash_value
and upper(d.sql_text) like '%WHERE CAMPO LIKE%'
ORDER BY c.sid, d.piece 

-- A SQL query (filtered by sid)
SELECT c.sid, d.piece, c.serial#, c.username, d.sql_text
FROM v$session c, v$sqltext d
WHERE c.sql_hash_value = d.hash_value
and sid = 105
ORDER BY c.sid, d.piece

-- Oracle SQL query to know the database size
select sum(BYTES)/1024/1024 MB from DBA_EXTENTS

-- Oracle SQL query to calculate the size of the database data files
select sum(bytes)/1024/1024 MB from dba_data_files

-- Oracle SQL query to calculate the size of a concrete table excluding the indexes
select sum(bytes)/1024/1024 MB from user_segments
where segment_type='TABLE' and segment_name='TABLENAME'

-- Oracle SQL query to calculate the size of a concrete table including the indexes
select sum(bytes)/1024/1024 Table_Allocation_MB from user_segments
where segment_type in ('TABLE','INDEX') and
(segment_name='TABLENAME'or segment_name in
(select index_name from user_indexes where table_name='TABLENAME'))

-- Oracle SQL query to know the memory used by a column in a table
select sum(vsize('COLUMNNAME'))/1024/1024 MB from 'TABLENAME'

-- Oracle SQL query to calculate memory used by a user
SELECT owner, SUM(BYTES)/1024/1024 MB FROM DBA_EXTENTS
group by owner

-- Oracle SQL query to calculate size from the diferent segments 
-- (tables, indexes, undo, rollback, cluster, ...)
SELECT SEGMENT_TYPE, SUM(BYTES)/1024/1024 MB FROM DBA_EXTENTS
group by SEGMENT_TYPE

-- Oracle SQL query to obtain all the Oracle functions: NVL, ABS, LTRIM, ...
SELECT distinct object_name
FROM all_arguments
WHERE package_name = 'STANDARD'
order by object_name

-- Oracle SQL query to calculate the size of all the database objects, ordering from more to less
SELECT SEGMENT_NAME, SUM(BYTES)/1024/1024 MB FROM DBA_EXTENTS
group by SEGMENT_NAME
order by 2 desc 
