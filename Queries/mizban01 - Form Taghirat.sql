use mizban_db;
select * from Users w where w.UserName='5726';
select * from Roles where UserID=17176;
select * from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=-1;
select SubjectID,w.* from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=83209;

select top 1000 * from [dbo].[PersonalArchive_Sends] 
where etc=767 and SubjectID in (select SubjectID from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=83209)




  entity_metadata ---اسامی فرم ها
  entitynumber
  select * from Entity_Metadata where EntityTypeFarsiName like N'%مجوز%';


  select * from Send_Receivers
  where ReceiverRoleID=18559 and SendCode in (select sendcode from sends where EntityTypeCode=767)
  and 

  select EntityCode,* from sends where EntityTypeCode=767 and SendCode in (select sendcode from Send_Receivers where ReceiverRoleID=18559)




  select * from Actions 
  
  select 
  --EntityNumber,tozihat,name,tozihat_karshenas_paygahdade,*
  count(*)
   From Entity_taghirat_paygahdade
  where EntityCode in (  select EntityCode from sends where EntityTypeCode=767 and SendCode in (select sendcode from Send_Receivers where ReceiverRoleID=18559))
  and EntityCode not in (
select ec from [dbo].[PersonalArchive_Sends] 
where etc=767 and SubjectID in (select SubjectID from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=83209)
) 
--and tozihat not like N'%سامانه ارز%'

select 
d.EntityNumber,
e.EntityTypeFarsiName, c.ActionName,a.EntityCode,a.EntityTypeCode,d.tozihat,d.name,d.tozihat_karshenas_paygahdade,d._tarikh,b.ResponseDate
from sends a,Send_Receivers b,Actions c,Entity_taghirat_paygahdade d,Entity_Metadata e
where 
1=1
and a.EntityTypeCode=767 
and a.SendCode=b.SendCode
and b.ReceiverRoleID=18559
and b.ActionCode=c.ActionCode
and a.EntityCode=d.EntityCode
--and b.ResponseDate is null
and a.EntityTypeCode=e.EntityTypeCode
and (d.name like N'%سل%')
order by d.EntityNumber desc


select top 1000 * from [dbo].[PersonalArchive_Sends] 
where etc=767 and SubjectID in (select SubjectID from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=83209)



insert into [dbo].[PersonalArchive_Sends] 
select 83209,a.EntityTypeCode,a.EntityCode,-1,0,null,getdate(),N'',18559,17176 
from sends a,Send_Receivers b,Actions c,Entity_taghirat_paygahdade d,Entity_Metadata e
where 
1=1
and a.EntityTypeCode=767 
and a.SendCode=b.SendCode
and b.ReceiverRoleID=18559
and b.ActionCode=c.ActionCode
and a.EntityCode=d.EntityCode
and b.ResponseDate is null
and a.EntityTypeCode=e.EntityTypeCode
order by d.EntityNumber desc




update Send_Receivers set
ResponseDate=getdate(),FinishedOperation=1
where Code in ( 
select b.Code 
from sends a,Send_Receivers b,Actions c,Entity_taghirat_paygahdade d,Entity_Metadata e
where 
1=1
and a.EntityTypeCode=767 
and a.SendCode=b.SendCode
and b.ReceiverRoleID=18559
and b.ActionCode=c.ActionCode
and a.EntityCode=d.EntityCode
and b.ResponseDate is null
and a.EntityTypeCode=e.EntityTypeCode
)

update ActiveSend_Receivers set
ResponseDate=getdate(),FinishedOperation=1
where Code in ( 
select b.Code from ActiveSends a,ActiveSend_Receivers b,Actions c,Entity_taghirat_paygahdade d,Entity_Metadata e
where 
1=1
and a.EntityTypeCode=767 
and a.SendCode=b.SendCode
and b.ReceiverRoleID=18559
and b.ActionCode=c.ActionCode
and a.EntityCode=d.EntityCode
and b.ResponseDate is null
and a.EntityTypeCode=e.EntityTypeCode
)




update PersonalArchive_Sends set archivetime=dateadd(second,ec-160,archivetime) where ID in (

select ID from PersonalArchive_Sends where roleid=18559 and userid=17176 and ArchiveTime >='2019-11-16'
) and  roleid=18559 and userid=17176 and ArchiveTime >='2019-11-16'




select * from SYS.DM_EXEC_SESSIONS 