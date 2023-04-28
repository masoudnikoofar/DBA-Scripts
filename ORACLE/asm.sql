-----root user
# oracleasm listdisks
# oracleasm scandisks
# oracleasm status
# oracleasm init
# oracleasm scandisks
# oracleasm listdisks


 
alter system set asm_diskstring='/dev/oracleasm/disks';

------ grid user
crs_stat -t
crsctl start resource ora.cssd
crsctl enable has

crsctl start has




crsctl status resource
crsctl start resource ora.dbtest12.db

srvctl start -help
srvctl start diskgroup -diskgroup ora.dbtest12.db
srvctl status -help
srvctl status diskgroup -diskgroup DATA




#Error: CRS-2640: Required resource 'ora.DATA02.dg' is missing.
#این خطا در مواقعی ممکن است رخ می دهد که یک diskgroup موجود را پاک کرده باشیم.

crsctl status resource ora.dbtest12.db -f | grep DATA02
srvctl disable diskgroup -g DATA02
srvctl remove diskgroup -g DATA02
srvctl modify database -d dbtest12 -a "DATA"














asmcmd -p => lsdg

lsdsk -d data -k
 
cp +DATA/db11g/datafile/users.273.661514191 /tmp/users.dbf
 
md_backup -b /tmp/backup.txt -g data
 
 
md_restore -b /tmp/backup.txt -t full -g data

remap data data_0001 5000-5999




---------

sqlplus as sysasm

SELECT group_number, name, value FROM v$asm_attribute ORDER BY group_number, name;
SELECT group_number, name, state FROM v$asm_diskgroup;


set linesize 10000
col path format a50

select GROUP_NUMBER,DISK_NUMBER,MOUNT_STATUS,STATE,OS_MB,TOTAL_MB,FREE_MB,NAME,PATH From v$asm_disk order by  1,2;



--DROP DISKGROUP DATA INCLUDING CONTENTS;
--DROP DISKGROUP LOG  INCLUDING CONTENTS;


--CREATE DISKGROUP DATA EXTERNAL REDUNDANCY DISK '/dev/oracleasm/disks/DATA*';
--CREATE DISKGROUP LOG  EXTERNAL REDUNDANCY DISK '/dev/oracleasm/disks/LOG*';
--CREATE DISKGROUP disk_group_2 EXTERNAL REDUNDANCY DISK '/dev/sde1' ATRRIBUTE 'au_size' = '32M';

--CREATE DISKGROUP LOG EXTERNAL REDUNDANCY DISK '/dev/oracleasm/disks/LOG01'; 





ALTER DISKGROUP DATA DROP DISK DATA_0006 REBALANCE POWER 11;
ALTER DISKGROUP DATA DROP DISK DATA_0010 REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD DISK '/dev/oracleasm/disks/DATA07' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD DISK '/dev/oracleasm/disks/DATA11' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD DISK '/dev/oracleasm/disks/DATA12' REBALANCE POWER 11;


SELECT group_number, operation, state, power,est_minutes FROM v$asm_operation;
 





 
ALTER DISKGROUP log CHECK; -- Like NOREPAIR
ALTER DISKGROUP data CHECK NOREPAIR;
ALTER DISKGROUP data CHECK REPAIR;











-- Individual disks.
ALTER DISKGROUP data OFFLINE DISK 'disk_0000', 'disk_0001';
ALTER DISKGROUP data ONLINE  DISK 'disk_0000', 'disk_0001';

-- Failure groups.
ALTER DISKGROUP data OFFLINE DISKS IN FAILGROUP 'fg_0000';
ALTER DISKGROUP data ONLINE DISKS IN FAILGROUP 'fg_0000';

-- Bring online all disks in disk group.
ALTER DISKGROUP data ONLINE ALL;





alter diskgroup data mount;
alter diskgroup log mount;
