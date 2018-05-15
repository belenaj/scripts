

DECLARE
  l_vSchemaName      VARCHAR2(100) := '';
  l_vNewSchemaName   VARCHAR2(100) := '';
  l_cOut             CLOB;
BEGIN

  FOR c IN (
    SELECT  TABLE_NAME
    FROM    USER_TABLES 
    WHERE   1 = 1 
  )
  LOOP
    l_cOut := ''; 
    
    SELECT 'GRANT SELECT ON "' || l_vSchemaName || '"."' || TABLE_NAME || '" TO ' || l_vNewSchemaName || ';'
    INTO    l_cOut 
    FROM    USER_TABLES u
    WHERE   TABLE_NAME = c.TABLE_NAME;  
     
    -- prints DDL
    DBMS_OUTPUT.PUT_LINE(l_cOut);
  END LOOP;
  

END;