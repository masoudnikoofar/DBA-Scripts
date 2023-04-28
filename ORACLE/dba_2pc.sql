select 'rollback force '''||local_tran_id||''' ;' from dba_2pc_pending where DB_USER='GIFTCARD';
select 'execute dbms_transaction.purge_lost_db_entry('''||local_tran_id||''' );' , 'commit;' from
dba_2pc_pending where DB_USER='GIFTCARD'

 select * from sys.pending_trans$;

