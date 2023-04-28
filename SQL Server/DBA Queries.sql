--SQL Server – Current queries executing on SQL Server
SELECT 
r.session_id,
s.TEXT,
r.[status],
r.blocking_session_id,
r.cpu_time,
r.total_elapsed_time
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s 
 

------------------------------------------------------------------------------
--SQL Server – Find sql text in active query with a sql derived table
(
 select OBJECT_NAME(ObjectID) as ObjectName,
  (SELECT TOP 1    SUBSTRING(s2.text,statement_start_offset / 2+1 ,
       ( (CASE WHEN statement_end_offset = -1 THEN (LEN(CONVERT(nvarchar(max),s2.text)) * 2)
        ELSE statement_end_offset END)  - statement_start_offset) / 2+1))  AS sql_statement ,
DB_NAME(er.database_ID) as dbname,er.open_transaction_count ,
 es.nt_user_name,es.nt_domain
FROM sys.dm_exec_sessions as es
INNER JOIN sys.dm_exec_requests as er ON er.session_id = es.session_id CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2 
) derived_table

where sql_statement LIKE '%my_search_term%'
------------------------------------------------------------------------------
select e.name as eventclass,
t.loginname, 
t.spid, 
t.starttime,
t.textdata, 
t.objectid, 
t.objectname, 
t.databasename, 
t.hostname, 
t.ntusername, 
t.ntdomainname, 
t.clientprocessid, 
t.applicationname, 
t.error 
FROM sys.fn_trace_gettable(CONVERT(VARCHAR(150), ( SELECT TOP 1f.[value] 
FROM sys.fn_trace_getinfo(NULL) f WHERE f.property = 2)), DEFAULT) T 
inner join sys.trace_events e on t.eventclass = e.trace_event_id 
where eventclass=164



--SQL Server - Table sizes and percentages
CREATE TABLE #temp(
tbl_id int IDENTITY (1, 1),
tbl_name varchar(128),
rows_num int,
data_space decimal(15,2),
index_space decimal(15,2),
total_size decimal(15,2),
percent_of_db decimal(15,12),
db_size decimal(15,2))
-- Get all tables, names, and sizes
EXEC sp_msforeachtable @command1="insert into #temp(rows_num, data_space, index_space) exec sp_mstablespace '?'",
@command2="update #temp set tbl_name = '?' where tbl_id = (select max(tbl_id) from #temp)"
-- Set the total_size and total database size fields
UPDATE #temp
SET total_size = (data_space + index_space), db_size = (SELECT SUM(data_space + index_space) FROM #temp)
-- Set the percent of the total database size
UPDATE #temp
SET percent_of_db = (total_size/db_size) * 100
-- Get the data
SELECT *
FROM #temp
ORDER BY total_size DESC
-- Comment out the following line if you want to do further querying
DROP TABLE #temp