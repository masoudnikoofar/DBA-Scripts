SELECT to_char(sysdate+LEVEL*7-805,'yyyy-mm-dd','nls_calendar=persian') as Saturdays 
 FROM DUAL
 CONNECT BY LEVEL<=800
