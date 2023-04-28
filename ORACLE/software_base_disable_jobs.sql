--to disable jobs
begin
  dbms_scheduler.disable(name => 'software_base.job1_dropproc1');
  dbms_scheduler.disable(name => 'software_base.job2_createproc2');
  dbms_scheduler.disable(name => 'software_base.job3_acntproc3');
  dbms_scheduler.disable(name => 'software_base.job4_cityproc4');
  dbms_scheduler.disable(name => 'software_base.job5_topproc5');
  dbms_scheduler.disable(name => 'software_base.job6_solati_utlfile');
end;

--to enable jobs
begin
  dbms_scheduler.enable(name => 'software_base.job1_dropproc1');
  dbms_scheduler.enable(name => 'software_base.job2_createproc2');
  dbms_scheduler.enable(name => 'software_base.job3_acntproc3');
  dbms_scheduler.enable(name => 'software_base.job4_cityproc4');
  dbms_scheduler.enable(name => 'software_base.job5_topproc5');
  dbms_scheduler.enable(name => 'software_base.job6_solati_utlfile');
end;
