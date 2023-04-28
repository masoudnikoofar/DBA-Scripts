--shutdown abort;
--startup nomount;
--startup mount;



sqlplus / as sysdba
recover managed standby database cancel;
-- Standby
select to_char(current_scn) from v$database;
-- Primary



rman target /
backup incremental from scn 1331348155446 database format '/u01/Backups/backup_gap_%U';
-- Guard
rman target /
catalog start with '/u01/Backups/';


recover database noredo;



-- Prim
backup current controlfile for standby;
--or
alter database create standby controlfile as '/u01/Backups/standby_control.ctl';


--standby
rman target /
startup nomount force;

RESTORE STANDBY CONTROLFILE FROM '/u01/Backups/standby_control.ctl'; 


--Standby
-- replace control file
--recover managed standby database cancel;
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






alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_06_23/o1_mf_1_104344_hh35n6k7_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_06_23/o1_mf_1_104344_hh3njx5n_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101982_h31jf96w_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101983_h31jgwg4_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101983_h33lv793_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101984_h32vr10y_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101984_h33lv6qo_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101985_h3317j5x_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101985_h33lv7hj_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101986_h331gw5v_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101986_h33lv6oz_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101987_h331kg1b_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101987_h33lv7j7_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/DISPGRD/archivelog/2020_01_29/o1_mf_1_101989_h33mkwg4_.arc';























