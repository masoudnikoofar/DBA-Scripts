--shutdown abort;
--startup nomount;
--startup mount;



sqlplus / as sysdba

-- Standby
select to_char(current_scn) from v$database;
-- Primary




backup incremental from scn 1076042454387 database format '/u01/Backups/backup_gap_%U';
-- Guard
catalog start with '/u01/Backups/1';
catalog start with '/u01/Backup/';

recover database noredo;



-- Prim
backup current controlfile for standby;
--or
alter database create standby controlfile as '/u01/Backups/standby_control.ctl';


--standby
RESTORE STANDBY CONTROLFILE FROM '/u01/Backups/standby_control.ctl'; 
RESTORE STANDBY CONTROLFILE FROM '/u01/Backup/standby_control.ctl'; 

--Standby
-- replace control file
recover managed standby database using current logfile disconnect from session;










--At the standby :
alter system set standby_file_management=manual;

--At the Primary for the datafile 167 :
alter tablespace system begin backup ;

--Copy the Datafile from the Primary to Standby to the correct location.
Alter tablespace system end backup; 

--At the Standby:
alter database rename file '+DATA/mbguard/datafile/system.270.814884899' to '/u01/system.dbf';






connect auxiliary sys/dbaEnbankORACLESYS@mbguard;
backup as copy  tablespace system auxiliary format '/u01/system.dbf';






--prim
backup as copy datafile 1 format '/u01/system.dbf';
--standby
shutdown
drop datafile
startup mount
rman target /
catalog datafilecopy '/u01/system.dbf';
list copy of datafile 1;
restore datafile 1;






alter database register logfile '+DATA/mbguard/archivelog/2017_11_21/thread_1_seq_13604.263.960626255';
