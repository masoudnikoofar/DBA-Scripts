SELECT  ROUTINE_NAME, ROUTINE_DEFINITION
FROM INFORMATION_SCHEMA.ROUTINES
WHERE (ROUTINE_DEFINITION LIKE '%string,%' OR ROUTINE_DEFINITION LIKE '%string%' )
AND ROUTINE_TYPE='PROCEDURE'



SELECT o.name AS Object_Name,o.type_desc,m.definition
FROM sys.sql_modules        m
INNER JOIN sys.objects  o ON m.object_id=o.object_id
WHERE upper(m.definition) Like '%string%'
ORDER BY 2,1