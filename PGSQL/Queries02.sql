#list of databases
\l 

#Switch DB
\c db_name

#Table Lists
\dt


drop database db_name; 

CREATE USER user_name WITH PASSWORD 'pass';
CREATE DATABASE db_name;
GRANT ALL PRIVILEGES ON DATABASE stockholders_portal_db to stockholders_portal_user;
GRANT CONNECT ON DATABASE stockholders_portal_db to stockholders_portal_user;



pg_restore --dbname=dbname --verbose \pathtobackup
pg_restore --dbname=mobilebank_db --verbose /DB_Backups/20190901