SELECT dbschemas.[name] as 'Schema',
dbtables.[name] as 'Table',
dbindexes.[name] as 'Index',
indexstats.avg_fragmentation_in_percent,
indexstats.page_count,
'alter index ' +  dbindexes.[name] + ' on ' + dbschemas.[name] + '.' + dbtables.[name] + ' rebuild;'
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
INNER JOIN sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
INNER JOIN sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
AND indexstats.index_id = dbindexes.index_id
WHERE indexstats.database_id = DB_ID()
ORDER BY indexstats.avg_fragmentation_in_percent desc;







----------------


DECLARE @Loop int
DECLARE @Loop2 int
DECLARE @MaxLoop int
DECLARE @MaxLoop2 int
DECLARE @DBName varchar(300)
DECLARE @SQL varchar(max)

SET @Loop = 1
SET @DBName = ''

set nocount on
SET @MaxLoop =  (select count([name]) FROM sys.databases where [name] like '%')
WHILE @Loop <= @MaxLoop
    BEGIN
        SET @DBName = (select TableWithRowsNumbers.name from (select ROW_NUMBER() OVER (ORDER by [name]) as Row,[name] FROM sys.databases where [name] like 'Z%' ) TableWithRowsNumbers where Row = @Loop)
        SET @SQL = 'USE [' + @DBName + ']'
        print (@SQL)
		exec (@SQL)
		
		SET @Loop2 = 1

		SET @MaxLoop2 =  (
		SELECT 
			Count(indexstats.database_id) 
			FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
			INNER JOIN sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
			INNER JOIN sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
			INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
			AND indexstats.index_id = dbindexes.index_id
			WHERE indexstats.database_id = DB_ID()
		);
		WHILE @Loop2 <= @MaxLoop2
			begin
			set @SQL = 
			(
				select xx.cmd from 
				(
					SELECT 
					ROW_NUMBER() OVER (ORDER by indexstats.avg_fragmentation_in_percent) as Row,
					indexstats.database_id ,
					dbschemas.[name] as 'Schema',
					dbtables.[name] as 'Table',
					dbindexes.[name] as 'Index',
					indexstats.avg_fragmentation_in_percent,
					indexstats.page_count,
					'alter index ' +  dbindexes.[name] + ' on ' + dbschemas.[name] + '.' + dbtables.[name] + ' rebuild;' as cmd
					FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
					INNER JOIN sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
					INNER JOIN sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
					INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
					AND indexstats.index_id = dbindexes.index_id
					WHERE indexstats.database_id = DB_ID()
				) xx where Row = @Loop2
			)
			exec (@SQL)
			print (@SQL)
			select xx.cmd from 
				(
					SELECT 
					ROW_NUMBER() OVER (ORDER by indexstats.avg_fragmentation_in_percent) as Row,
					indexstats.database_id ,
					dbschemas.[name] as 'Schema',
					dbtables.[name] as 'Table',
					dbindexes.[name] as 'Index',
					indexstats.avg_fragmentation_in_percent,
					indexstats.page_count,
					'alter index ' +  dbindexes.[name] + ' on ' + dbschemas.[name] + '.' + dbtables.[name] + ' reorganize;' as cmd
					FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
					INNER JOIN sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
					INNER JOIN sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
					INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
					AND indexstats.index_id = dbindexes.index_id
					WHERE indexstats.database_id = DB_ID()
				) xx where Row = @Loop2
			)
			exec (@SQL)
			print (@SQL)
			set @Loop2 = @Loop2+1;
		end
        set @Loop = @Loop + 1;
    END