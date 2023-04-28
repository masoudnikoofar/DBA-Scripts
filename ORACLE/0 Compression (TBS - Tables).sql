ALTER TABLESPACE tbs_name DEFAULT COMPRESS;
----------------------------------------------------------------------------------------------------------------------------------
SELECT X.TABLESPACE_NAME,X.COMPRESS_FOR FROM DBA_TABLESPACES X;
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE tbl_name COMPRESS;
ALTER TABLE tbl_name MOVE COMPRESS;
----------------------------------------------------------------------------------------------------------------------------------
SELECT 'ALTER TABLE ' || OWNER || '.' || SEGMENT_NAME || ' COMPRESS;' FROM DBA_SEGMENTS X WHERE X.TABLESPACE_NAME IN ('SAAB_TBS') AND X.SEGMENT_TYPE='TABLE';
SELECT 'ALTER TABLE ' || OWNER || '.' || SEGMENT_NAME || ' MOVE COMPRESS;' FROM DBA_SEGMENTS X WHERE X.TABLESPACE_NAME IN ('SAAB_TBS') AND X.SEGMENT_TYPE='TABLE';




SELECT 'ALTER TABLE ' || OWNER || '.' || SEGMENT_NAME || ' MOVE PARTITION ' || PARTITION_NAME || ' TABLESPACE TBS_KCTRANS1397 COMPRESS;' FROM DBA_SEGMENTS X WHERE X.TABLESPACE_NAME IN ('KCTRANS1397') AND X.SEGMENT_TYPE='TABLE PARTITION';
