/*
By default Oracle databases do not audit SQL commands executed by the privileged SYS, and users connecting with SYSDBA or SYSOPER privileges. If your database is hacked, these privileges are going to the be the hackers first target. Fortunately auditing SQL commands of these privileged users is very simple:
*/
alter system set audit_sys_operations=true scope=spfile;

/*
Note: The command above would enable auditing from the database, but not the database vault information, into the table SYS.AUD$. There are actually four database auditing types: OS, DB, EXTENDED, and XML.
*/

alter system set audit_trail=DB,EXTENDED scope=spfile;

 



AUDIT ALL BY enbdba BY ACCESS;
AUDIT SELECT TABLE, UPDATE TABLE, INSERT TABLE, DELETE TABLE BY masoud BY ACCESS;
AUDIT EXECUTE PROCEDURE BY enbdba BY ACCESS;



select
'AUDIT ALL BY ' ||t.username || ' BY ACCESS;'
 from dba_users t where t.username in (
 'DWH_MALIDM2                  ',
'DWH_MODERNDM',
'SEPAM',
'TECHNO',
'DWH_DEPOSITDM',
'PRIVATE_BANKING',
'ARZI_REP_02',
'DWH_DEPOSITDM2',
'RAYAN_BPE',
'VB_RAYAN',
'RAYAN_ROTBEHSANJI',
'ARZI_REP',
'RISK',
'CUSTOMER_PROFILE',
'SOFTWARE_BASE',
'DWH_MALIDM',
'NABZAFZAR',
'DWH_CURRENCYDM',
'CBI',
'PORTAL',
'DWH_LOANDM',
'DWH_AMLDM',
'SWEN',
'ENBDBA',
'DEP_INTEREST',
'REPORTER',
'DWH_LOANDM2',
'TB_PISHKHAN',
'DWH_CUSTOMERDM',
'CRM_FA',
'REPORT',
'SOFTWARE2',
'DWH_COMMONAREADM',
'ENBDBA_SOFT',
'DWH_CARDDM',
'SECURE',
'PRODUCT',
'DWH_FRAUD2DM',
'KAVOSHGAR',
'GOLDENGATE_LOGIN',
'RAYAN_SATISFACTION',
'INSURANCE',
'SOFTWARE',
'KPI',
'CHAKAVAK_REP',
'ENBDBA_REPORT',
'SHAREPOINT',
'CORPORATE_BANKING',
'EG_APP'
 )
union 
select
'AUDIT SELECT TABLE, UPDATE TABLE, INSERT TABLE, DELETE TABLE BY ' ||t.username || ' BY ACCESS;'
 from dba_users t where t.username in (
 'DWH_MALIDM2                  ',
'DWH_MODERNDM',
'SEPAM',
'TECHNO',
'DWH_DEPOSITDM',
'PRIVATE_BANKING',
'ARZI_REP_02',
'DWH_DEPOSITDM2',
'RAYAN_BPE',
'VB_RAYAN',
'RAYAN_ROTBEHSANJI',
'ARZI_REP',
'RISK',
'CUSTOMER_PROFILE',
'SOFTWARE_BASE',
'DWH_MALIDM',
'NABZAFZAR',
'DWH_CURRENCYDM',
'CBI',
'PORTAL',
'DWH_LOANDM',
'DWH_AMLDM',
'SWEN',
'ENBDBA',
'DEP_INTEREST',
'REPORTER',
'DWH_LOANDM2',
'TB_PISHKHAN',
'DWH_CUSTOMERDM',
'CRM_FA',
'REPORT',
'SOFTWARE2',
'DWH_COMMONAREADM',
'ENBDBA_SOFT',
'DWH_CARDDM',
'SECURE',
'PRODUCT',
'DWH_FRAUD2DM',
'KAVOSHGAR',
'GOLDENGATE_LOGIN',
'RAYAN_SATISFACTION',
'INSURANCE',
'SOFTWARE',
'KPI',
'CHAKAVAK_REP',
'ENBDBA_REPORT',
'SHAREPOINT',
'CORPORATE_BANKING',
'EG_APP')

union 
select

'AUDIT EXECUTE PROCEDURE BY ' ||t.username || ' BY ACCESS;'

 from dba_users t where t.username in (
 'DWH_MALIDM2                  ',
'DWH_MODERNDM',
'SEPAM',
'TECHNO',
'DWH_DEPOSITDM',
'PRIVATE_BANKING',
'ARZI_REP_02',
'DWH_DEPOSITDM2',
'RAYAN_BPE',
'VB_RAYAN',
'RAYAN_ROTBEHSANJI',
'ARZI_REP',
'RISK',
'CUSTOMER_PROFILE',
'SOFTWARE_BASE',
'DWH_MALIDM',
'NABZAFZAR',
'DWH_CURRENCYDM',
'CBI',
'PORTAL',
'DWH_LOANDM',
'DWH_AMLDM',
'SWEN',
'ENBDBA',
'DEP_INTEREST',
'REPORTER',
'DWH_LOANDM2',
'TB_PISHKHAN',
'DWH_CUSTOMERDM',
'CRM_FA',
'REPORT',
'SOFTWARE2',
'DWH_COMMONAREADM',
'ENBDBA_SOFT',
'DWH_CARDDM',
'SECURE',
'PRODUCT',
'DWH_FRAUD2DM',
'KAVOSHGAR',
'GOLDENGATE_LOGIN',
'RAYAN_SATISFACTION',
'INSURANCE',
'SOFTWARE',
'KPI',
'CHAKAVAK_REP',
'ENBDBA_REPORT',
'SHAREPOINT',
'CORPORATE_BANKING',
'EG_APP')




