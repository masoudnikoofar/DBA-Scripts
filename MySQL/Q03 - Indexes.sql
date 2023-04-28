SELECT
    DISTINCT TABLE_NAME,
    INDEX_NAME,a.*
FROM
    INFORMATION_SCHEMA.STATISTICS a
WHERE
    TABLE_SCHEMA = 'tamashakhoneh_db';
	
----------

SHOW INDEXES FROM tbl_name;

REINDEX INDEX [Index_Name];
REINDEX TABLE [TableName]; or,
REINDEX TABLE [TableName]([ColumnName of the TableName]);
REINDEX DATABASE [DatabaseName];

OPTIMIZE TABLE tbl_name;

