exec dbms_xdb_config.sethttpsport(port-number);
exec dbms_xdb_config.SetGlobalPortEnabled(TRUE);

select dbms_xdb_config.getHttpsPort() from dual;
