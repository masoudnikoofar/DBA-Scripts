use mizban_db;
select * from Users w where w.UserName='5726';
select * from Roles where UserID=17176;
select * from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=-1;
select SubjectID,w.* from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=83206;

select top 1000 * from [dbo].[PersonalArchive_Sends] 
where etc=800 and SubjectID in (select SubjectID from PersonalArchive w where w.UserID=17176 and w.RoleID=18559 and ParentID=83206)


select * from Entity_Metadata x where x.EntityTypeFarsiName like N'%اطلاع%'
--ETC=659

select * from entity_Etelaeeye_Bakhshname



  select * from Send_Receivers
  where ReceiverRoleID=18559 and SendCode in (select sendcode from sends where EntityTypeCode=659)
  

  select EntityCode,* from sends where EntityTypeCode=659 and SendCode in (select sendcode from Send_Receivers where ReceiverRoleID=18559)






update Send_Receivers set
ResponseDate=getdate(),FinishedOperation=1
where Code in ( 
select b.Code 
from sends a,Send_Receivers b,Actions c,entity_Etelaeeye_Bakhshname d,Entity_Metadata e
where 
1=1
and a.EntityTypeCode=659 
and a.SendCode=b.SendCode
and b.ReceiverRoleID=18559
and b.ActionCode=c.ActionCode
and a.EntityCode=d.EntityCode
and a.EntityTypeCode=e.EntityTypeCode
)

update ActiveSend_Receivers set
ResponseDate=getdate(),FinishedOperation=1
where Code in ( 
select b.Code from ActiveSends a,ActiveSend_Receivers b,Actions c,entity_Etelaeeye_Bakhshname d,Entity_Metadata e
where 
1=1
and a.EntityTypeCode=659 
and a.SendCode=b.SendCode
and b.ReceiverRoleID=18559
and b.ActionCode=c.ActionCode
and a.EntityCode=d.EntityCode
and a.EntityTypeCode=e.EntityTypeCode
)



