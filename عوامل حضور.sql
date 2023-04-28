

select s.code, trunc(sum(e.extratime-trunc(e.extratime))*24) || ':'
|| trunc((sum(e.extratime-trunc(e.extratime))*24 - trunc(sum(e.extratime-trunc(e.extratime))*24)) * 60)
  from erp_enbank.hrm_opc_entandexitfactors e, erp_enbank.hrm_opc_entranceandexit ee, erp_enbank.hrm_slc_salary s 
  
  
  
  where employee_id=6419
  and ee.salaryperiod_id = s.id
   and e.entranceAndExit_id=ee.id

group by s.code
