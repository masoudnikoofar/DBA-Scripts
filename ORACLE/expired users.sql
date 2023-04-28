select 'alter user ' || su.name || ' identified by values ' || '''' || spare4 || ';' || su.password||''';'
from sys.user$ su join dba_users du
on account_status like 'EXPIRED%'
and su.name=du.username;




create profile APP_USERS_PROFILE limit password_life_time unlimited;




