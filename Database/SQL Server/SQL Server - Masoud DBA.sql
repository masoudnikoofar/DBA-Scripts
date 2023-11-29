USE MASTER;
--------------------------------------------------------------------
CREATE VIEW [DBO].[MASOUD_DBA_SESSION]
AS
SELECT     TOP (100) PERCENT SESSION_ID, LOGIN_TIME, HOST_NAME, PROGRAM_NAME, STATUS, CPU_TIME, TOTAL_ELAPSED_TIME, 'KILL ' + CONVERT(VARCHAR(5), SESSION_ID) 
                      + ';' AS KILL_COMMAND
FROM         SYS.DM_EXEC_SESSIONS AS X;
--------------------------------------------------------------------
CREATE VIEW [DBO].[MASOUD_DBA_JOB_RUN_DETAILES]
AS
SELECT     A.NAME AS JOB_NAME, B.RUN_STATUS, 
                      CASE B.RUN_STATUS WHEN 0 THEN 'FAILED' WHEN 1 THEN 'SUCCESSFUL' WHEN 2 THEN 'RETRY' WHEN 3 THEN 'CANCELLED' ELSE 'OTHER' END AS RUN_STATUS_DESC, 
                      B.MESSAGE, B.RUN_DATE, B.RUN_TIME, MSDB.DBO.AGENT_DATETIME(B.RUN_DATE, B.RUN_TIME) AS RUN_DATETIME, B.RUN_DURATION
FROM         MSDB.DBO.SYSJOBS_VIEW AS A INNER JOIN
                      MSDB.DBO.SYSJOBHISTORY AS B ON A.JOB_ID = B.JOB_ID
WHERE     (A.NAME LIKE 'GMP.%');
--------------------------------------------------------------------
CREATE VIEW [DBO].[MASOUD_DBA_JOB_RUN_DETAILES_DAILY]
AS
SELECT     A.NAME AS JOB_NAME, B.RUN_STATUS, 
                      CASE B.RUN_STATUS WHEN 0 THEN 'FAILED' WHEN 1 THEN 'SUCCESSFUL' WHEN 2 THEN 'RETRY' WHEN 3 THEN 'CANCELLED' ELSE 'OTHER' END AS RUN_STATUS_DESC, 
                      B.MESSAGE, B.RUN_DATE, B.RUN_TIME, MSDB.DBO.AGENT_DATETIME(B.RUN_DATE, B.RUN_TIME) AS RUN_DATETIME, B.RUN_DURATION
FROM         MSDB.DBO.SYSJOBS_VIEW AS A INNER JOIN
                      MSDB.DBO.SYSJOBHISTORY AS B ON A.JOB_ID = B.JOB_ID
WHERE     (A.NAME LIKE 'GMP.%')
AND MSDB.DBO.AGENT_DATETIME(RUN_DATE, RUN_TIME)>= DATEADD(DAY, DATEDIFF(DAY,0,GETDATE()),0);
/*
use master;
grant select on [master].[dbo].[MASOUD_DBA_JOB_RUN_DETAILES_DAILY] to DBMONITORING;
use msdb;
execute sp_addrolemember 
@rolename ='SQLAgentReaderRole',
@membername ='DBMONITORING';
*/
--------------------------------------------------------------------
select * From [DBO].[MASOUD_DBA_BACKUP_RESTORE_PROGRESS]
CREATE VIEW [DBO].[MASOUD_DBA_BACKUP_RESTORE_PROGRESS] as
SELECT r.session_id AS [Session_Id]
    ,r.command AS [command]
    ,CONVERT(NUMERIC(6, 2), r.percent_complete) AS [Complete]
    ,GETDATE() AS [Current Time]
    ,CONVERT(VARCHAR(20), DATEADD(ms, r.estimated_completion_time, GetDate()), 20) AS [Estimated Completion Time]
    ,CONVERT(NUMERIC(32, 2), r.total_elapsed_time / 1000.0 / 60.0) AS [Elapsed Min]
    ,CONVERT(NUMERIC(32, 2), r.estimated_completion_time / 1000.0 / 60.0) AS [Estimated Min]
    ,CONVERT(NUMERIC(32, 2), r.estimated_completion_time / 1000.0 / 60.0 / 60.0) AS [Estimated Hours]
    ,CONVERT(VARCHAR(1000), (
            SELECT SUBSTRING(TEXT, r.statement_start_offset / 2, CASE
                        WHEN r.statement_end_offset = - 1
                            THEN 1000
                        ELSE (r.statement_end_offset - r.statement_start_offset) / 2
                        END) 'Statement text'
            FROM sys.dm_exec_sql_text(sql_handle)
            )) as full_command
FROM sys.dm_exec_requests r
WHERE command like 'RESTORE%'
or  command like 'BACKUP%';
