#list of databases
\l 

#Switch DB
\c DB_NAME

#Table Lists
\dt


drop database DB_NAME; 

CREATE USER USER_NAME WITH PASSWORD 'pass';
CREATE DATABASE DB_NAME;
GRANT ALL PRIVILEGES ON DATABASE DB_NAME to USER_NAME;
GRANT CONNECT ON DATABASE DB_NAME to USER_NAME;



pg_restore --dbname=DB_NAME --verbose /PATH/TO/BACKUP
