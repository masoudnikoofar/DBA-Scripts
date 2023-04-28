BEGIN
  DBMS_AUDIT_MGMT.INIT_CLEANUP(AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,DEFAULT_CLEANUP_INTERVAL => 240 /*hours*/);
END;
/




declare
  date1       date;
  date_start  date := to_date('13961124 000000',
                              'yyyymmdd hh24miss',
                              'nls_calendar=persian');
  date_finish date := to_date('13961126 000000',
                              'yyyymmdd hh24miss',
                              'nls_calendar=persian');

begin
  date1 := date_start;
  while date1<date_finish loop
    begin
      DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(audit_trail_type  => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
                                                 last_archive_time => date1);
    end;
  
    BEGIN
      DBMS_AUDIT_MGMT.clean_audit_trail(audit_trail_type        => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
                                        use_last_arch_timestamp => TRUE);
    END;
    date1 := date1 + 1 / 1440; --one minute
  end loop;

end;
