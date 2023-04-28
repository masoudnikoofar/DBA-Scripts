--shutdown abort;
--startup nomount;
--startup mount;


--Standby
sqlplus / as sysdba
recover managed standby database cancel;

-- Standby
select to_char(current_scn) from v$database;
select to_char(timestamp_to_scn(to_timestamp('20191109','yyyymmdd'))) from dual 
select scn_to_timestamp(1329833610564) from dual; 
-- Primary
$ rman target /
RMAN> backup incremental from scn 1313151441467 database format '/u01/Backups/backup_gap_%U';
$ sqlplus / as sysdba
SQL> alter database create standby controlfile as '/u01/Backups/standby_control.ctl';-- before rsync
rsync -avzh --progress /u01/Backups/* oracle@172.17.248.51:/u01/Backups/

-- Guard
$ rman target /
RMAN> catalog start with '/u01/Backups/';
RMAN> shutdown immediate;
RMAN> startup mount;
RMAN> recover database noredo;
RMAN> shutdown immediate;
RMAN> startup nomount;
RMAN> RESTORE STANDBY CONTROLFILE FROM '/u01/Backups/standby_control.ctl'; 
RMAN> alter database mount;

 --tailf /home/oracle/alert_tfrayanst.log
$ sqlplus / as sysdba
SQL> recover managed standby database using current logfile disconnect from session;


--Standby
-- replace control file



RESTORE STANDBY CONTROLFILE from '/u01/app/oracle/fast_recovery_area/ERP/backupset//u01/app/oracle/fast_recovery_area/ERP/backupset/db11g_stby.ctl';







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






alter database register logfile '/u01/oracle/fast_recovery_area/TFRAYANST/archivelog/2019_12_26/o1_mf_1_32694_h08yq3d0_.arc';
alter database register logfile '/u01/oracle/fast_recovery_area/TFRAYANST/archivelog/2019_12_26/o1_mf_1_32695_h08ylwn9_.arc';
--------
--password file 
 rm -rf orapwtfrayanen
 orapwd entries=10 force=yes file=orapwtfrayanen
rsync -avzh --progress orapwtfrayanen  oracle@172.17.248.51:/u01/Backups/


