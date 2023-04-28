select UTL_INADDR.get_host_address,b.INSTANCE_NAME,b.HOST_NAME,a.username,a.profile,a.account_status,to_char(a.created,'yyyy/mm/dd','nls_calendar=persian') as created
 from dba_users a,v$instance b
 order by a.account_status,a.username;
 select * from dba_tab_privs 
 select * From dba_role_privs order by 1,2;
 select * From dba_sys_privs order by 1,2;
 select * from dba_role_privs x where x.granted_role='CONNECT';
