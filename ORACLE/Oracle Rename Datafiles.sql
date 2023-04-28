$ sqlplus / as sysdba
SQL> startup mount;
SQL> select x.file#,name from v$datafile x;
     FILE# NAME
-----------------------------------------------------
         1 /u01/app/oracle/oradata/hildadb/system01.dbf
         2 /u01/app/oracle/oradata/hildadb/sysaux01.dbf
         3 /u01/app/oracle/oradata/hildadb/undotbs01.dbf
         4 /u01/app/oracle/oradata/hildadb/users01.dbf
         5 /u01/app/oracle/oradata/hildadb/example01.dbf
         6 /u01/MYTBS01.DBF
         7 /u01/mytbs02.dbf
         8 /u01/HILDADB/datafile/o1_mf_mytbs_f3n94g9q_.dbf
         9 /u01/HG.DBF
        10 /u01/HG2.dbf
        11 /u01/HILDADB/datafile/o1_mf_masoud_f3ygl1gr_.dbf
        12 /u01/app/oracle/product/saghar01.dbf
        13 /u01/saghar01.dbf
        14 /u01/saghar02.dbf
        15 /u01/ma1.DBF
        16 /u01/ma2.DBF
        17 /u01/saghar/saghar01.dbf


$ mv /u01/saghar/saghar01.dbf /u01/saghar2/
$ sqlplus / as sysdba
SQL> alter database rename file '/u01/saghar/saghar01.dbf' to '/u01/saghar2/saghar01.dbf';
Database altered.
SQL> alter database open;

Database altered.

SQL> select x.file#,name from v$datafile x;
     FILE# NAME
-----------------------------------------------------
         1 /u01/app/oracle/oradata/hildadb/system01.dbf
         2 /u01/app/oracle/oradata/hildadb/sysaux01.dbf
         3 /u01/app/oracle/oradata/hildadb/undotbs01.dbf
         4 /u01/app/oracle/oradata/hildadb/users01.dbf
         5 /u01/app/oracle/oradata/hildadb/example01.dbf
         6 /u01/MYTBS01.DBF
         7 /u01/mytbs02.dbf
         8 /u01/HILDADB/datafile/o1_mf_mytbs_f3n94g9q_.dbf
         9 /u01/HG.DBF
        10 /u01/HG2.dbf
        11 /u01/HILDADB/datafile/o1_mf_masoud_f3ygl1gr_.dbf
        12 /u01/app/oracle/product/saghar01.dbf
        13 /u01/saghar01.dbf
        14 /u01/saghar02.dbf
        15 /u01/ma1.DBF
        16 /u01/ma2.DBF
        17 /u01/saghar2/saghar01.dbf