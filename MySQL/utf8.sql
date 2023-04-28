alter table hdd_base_catchers modify fullname varchar(50) character set utf8 collate utf8_unicode_ci;
update hdd_base_catchers set fullname=cast(convert(fullname using latin1) as binary)


alter table dbs_backup_checklist modify comment text character set utf8 collate utf8_unicode_ci;
update dbs set project_name= convert(cast(convert(project_name using latin1) as binary) using utf8)
