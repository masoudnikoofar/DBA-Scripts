--ba command zir path logfile ha neshan dade mishavad.

select a.group#, a.member,b."STATUS",b."BYTES" from v$logfile a, v$log b where a.group# = b.group# order by 1;
select a.group#, a.member,b."STATUS",to_char(b."BYTES") from v$logfile a, v$log b where a.group# = b.group# order by 1;

select group# , status from v$log;

--har kodam ke CURRENT bood, az logfile badi shoro kon.


alter database drop logfile group 2 ;
alter database drop standby logfile group 6

--agar ba error roo be roo shodi, command zir ro ejra kon

alter system checkpoint global;
--bad mojadadan command 

alter database drop logfile group ...;
--ejra kon.

--alter database add logfile group 3 ('/u01/app/oracle/oradata/orcl/redo01.log') size 100m reuse;

--ba dadane command select group#, status from v$log;
--bayad logfile marboote UNUSED bashad.

--hala in proce ro baraye logfile badi ke current NIST, ejra kon.

--sepas command zire ro ejra kon ta oun logfile ke taghir nakarde ro betooni resize koni.
alter system switch logfile;


alter system switch logfile;
alter system checkpoint global;




ALTER DATABASE ADD LOGFILE  member '/oracle/oradata/CURACAO9/redo02b.log' reuse to GROUP 2;



alter system switch logfile;
alter system checkpoint global;

alter database drop logfile group 4;

	alter system set DB_CREATE_ONLINE_LOG_DEST_1 = '/u01/app/oracle/oradata/dbtest12';
	alter system set DB_CREATE_ONLINE_LOG_DEST_2 = '+DATA';


alter database add logfile  group 2 size 1G;
alter database add logfile  group 4 size 10737418240;





