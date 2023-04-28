select to_char(t.date_,'yyyy/mm/dd','nls_calendar=persian') as dd,to_char(t.ENTRANCE,'hh24mi') ent,to_char(t.EXIT_,'hh24mi') ext, t.* from source_Erp.HRM_OPC_ENT_EXIT_ITEM_DETAIL t where t.personelcode=5726 and 
to_char(t.date_,'yyyy/mm','nls_calendar=persian')='1399/06'
and t.ENTRANCE>=to_date('0745','hh24mi')
and t.ENTRANCE<=to_date('0830','hh24mi')
/*
declare
minute_ char(2) :=to_char(trunc(dbms_random.value(39,45)));
ID_ number:= 11339738;
begin
update erp_enbank.HRM_OPC_ENT_EXIT_ITEM_DETAIL set entrance=to_date(to_char(entrance,'yyyymmdd') || ' 07' || minute_ || '00','yyyymmdd hh24miss') 
where ID=ID_;
update erp_enbank.hrm_opc_ent_exit_idet_log set entrance=to_date(to_char(entrance,'yyyymmdd') || ' 07' || minute_ || '00','yyyymmdd hh24miss'),
newentrance=to_date(to_char(entrance,'yyyymmdd') || ' 07' || minute_ || '00','yyyymmdd hh24miss') where
 entranceandexititemdetail_id=ID_;

commit;
end;
*/
