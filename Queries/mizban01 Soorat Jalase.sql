use mizban_db;
select * from Users w where w.UserName='5726';
select * from Roles where UserID=17176;
select * from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=-1;
select SubjectID,w.* from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=83206;

select top 1000 * from [dbo].[PersonalArchive_Sends] 
where etc=800 and SubjectID in (select SubjectID from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=83206)


select * from Entity_Metadata w where w.EntityTypeFarsiName like N'%صورتجلسه%'
select * from entity_soratjalase_IT

--ETC=800

  select * from Send_Receivers
  where ReceiverRoleID=18559 and SendCode in (select sendcode from sends where EntityTypeCode=800)
  

  select EntityCode,* from sends where EntityTypeCode=800 and SendCode in (select sendcode from Send_Receivers where ReceiverRoleID=18559)




  select * from Actions
  
--and tozihat not like N'%سامانه ارز%'

select 
d.EntityNumber,
d.mozo,d.tarikh_jalase,
e.EntityTypeFarsiName, c.ActionName,a.EntityCode,a.EntityTypeCode,b.ResponseDate
from sends a,Send_Receivers b,Actions c,entity_soratjalase_IT d,Entity_Metadata e
where 
1=1
and a.EntityTypeCode=800 
and a.SendCode=b.SendCode
and b.ReceiverRoleID=18559
and b.ActionCode=c.ActionCode
and a.EntityCode=d.EntityCode
--and b.ResponseDate is null
and a.EntityTypeCode=e.EntityTypeCode
order by d.EntityCode desc




update Send_Receivers set
ResponseDate=getdate(),FinishedOperation=1
where Code in ( 
select b.Code from sends a,Send_Receivers b,Actions c,entity_soratjalase_IT d,Entity_Metadata e
where 
1=1
and a.EntityTypeCode=800 
and a.SendCode=b.SendCode
and b.ReceiverRoleID=18559
and b.ActionCode=c.ActionCode
and a.EntityCode=d.EntityCode
--and b.ResponseDate is null
and a.EntityTypeCode=e.EntityTypeCode
)

update ActiveSend_Receivers set
ResponseDate=getdate(),FinishedOperation=1
where Code in  ( 
select b.Code from sends a,Send_Receivers b,Actions c,entity_soratjalase_IT d,Entity_Metadata e
where 
1=1
and a.EntityTypeCode=800 
and a.SendCode=b.SendCode
and b.ReceiverRoleID=18559
and b.ActionCode=c.ActionCode
and a.EntityCode=d.EntityCode
--and b.ResponseDate is null
and a.EntityTypeCode=e.EntityTypeCode
)