BEGIN
	DBMS_SQLTUNE.CREATE_SQLSET
	(
		SQLSET_NAME => 'SQL_SET_NAME',
		DESCRIPTION => 'SOME COMMENT'
	);
END;


SELECT DBMS_SQLTUNE.REPORT_SQL_MONITOR(SQL_ID => 'SQL ID',TYPE => 'TEXT' , REPORT_LEVEL => 'ALL') AS REPORT FROM DUAL;