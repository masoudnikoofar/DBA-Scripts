alter table TABLE_NAME modify COLUMN_NAME varchar(50) character set utf8 collate utf8_unicode_ci;
update TABLE_NAME set COLUMN_NAME=cast(convert(COLUMN_NAME using latin1) as binary)


alter table TABLE_NAME modify COLUMN_NAME text character set utf8 collate utf8_unicode_ci;
update TABLE_NAME set COLUMN_NAME= convert(cast(convert(COLUMN_NAME using latin1) as binary) using utf8)
