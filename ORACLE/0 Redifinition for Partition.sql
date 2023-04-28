begin
dbms_redefinition.can_redef_table('MPC','"MobileFinancialService"');
dbms_redefinition.start_redef_table('MPC','"MobileFinancialService"', 'MOBILEFINANCIALSERVICE');
dbms_redefinition.sync_interim_table('MPC','"MobileFinancialService"','MOBILEFINANCIALSERVICE');
dbms_redefinition.finish_redef_table('MPC','"MobileFinancialService"','MOBILEFINANCIALSERVICE');
end;

--ALTER INDEX big_table_pk2 RENAME TO big_table_pk;

SELECT 'ALTER INDEX ' || OWNER || '."' || INDEX_NAME || '_2" RENAME TO ' || OWNER || '."' || INDEX_NAME ||'";' FROM DBA_INDEXES X WHERE X.TABLE_NAME='Inbox';
--ALTER TABLE big_table RENAME CONSTRAINT bita_look_fk2 TO bita_look_fk;
SELECT 'ALTER TABLE ' || OWNER || '."' || TABLE_NAME || '" RENAME CONSTRAINT ' || '"' || CONSTRAINT_NAME || '_2" RENAME TO ' || '"' || CONSTRAINT_NAME ||'";' FROM DBA_CONSTRAINTS X WHERE X.TABLE_NAME='Inbox';