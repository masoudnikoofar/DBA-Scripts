--TO DISABLE JOBS
BEGIN
	DBMS_SCHEDULER.DISABLE(NAME => 'SCHEMA.JOB_NAME');
END;

--TO ENABLE JOBS
BEGIN
	DBMS_SCHEDULER.ENABLE(NAME => 'SCHEMA.JOB_NAME');
END;
