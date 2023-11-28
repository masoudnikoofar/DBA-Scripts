set lines 1000;
col owner format a30;
col db_link format a30;
col username format a30;
col host format a100;
select owner,db_link,username,host from dba_db_links;
