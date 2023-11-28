rm -rf /var/www/html/OracleLinux/7.3/latest/x86_64/repodata/*
wget -r -nH -nd -np -R index.html* http://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/repodata/ -P /var/www/html/OracleLinux/7.3/latest/x86_64/repodata/ 
