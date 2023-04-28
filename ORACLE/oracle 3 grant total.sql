BEGIN
  FOR Rec IN (SELECT object_name, object_type FROM all_objects WHERE owner='RISK' AND object_type IN ('VIEW')) LOOP
    IF Rec.object_type IN ('TABLE','VIEW') THEN
      EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE, INSERT, DELETE ON SOURCEUSER.'||Rec.object_name||' TO TARGETUSER';
    ELSIF Rec.object_type IN ('PROCEDURE','FUNCTION','PACKAGE') THEN
      EXECUTE IMMEDIATE 'GRANT EXECUTE ON SOURCEUSER.'||Rec.object_name||' TO TARGETUSER';
    END IF;
  END LOOP;
END;
