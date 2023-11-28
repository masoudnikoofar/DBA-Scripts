--Standby
$ sqlplus / as sysdba
SQL> recover managed standby database cancel;
SQL> select to_char(current_scn) from v$database;



-- Primary
--rm -rf /u01/Backups/backup_gap_*
$ rman target /
RMAN> backup incremental from scn 1329833610564 database format '/u01/Backups/backup_gap_%U';

$ sqlplus / as sysdba

SQL> alter database create standby controlfile as '/u01/Backups/standby_control.ctl';-- before rsync
--backup current controlfile for standby;

$ rsync -avzh --progress /u01/Backups/* oracle@172.17.251.33:/u01/Backups

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

$ sqlplus / as sysdba
SQL> recover managed standby database using current logfile disconnect from session;
 --tailf /home/oracle/alert_tfrayanst.log




---------------------------------------------------------------------------------------------



alter database register logfile '/u01/app/oracle/fast_recovery_area/ERPGRD/archivelog/2019_11_30/o1_mf_1_2380_gy46fwq1_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/ERPGRD/archivelog/2019_11_30/o1_mf_1_2381_gy4628fz_.arc';
alter database register logfile '/u01/app/oracle/fast_recovery_area/ERPGRD/archivelog/2019_11_30/o1_mf_1_2381_gy4nlobd_.arc';
------
--password file 
 rm -rf orapwtfrayanen
 orapwd entries=10 force=yes file=orapwtfrayanen
rsync -avzh --progress orapwtfrayanen  oracle@172.17.248.51:/u01/Backups/



