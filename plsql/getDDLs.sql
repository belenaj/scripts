-- *****************************************************************
-- Description: Returns by DBMS_OUTPUT the list of the columns
-- for the given table
--
-- Input Parameters:
--
-- Output Parameters:
--
-- Error Conditions Raised:
--
-- Author: J.Belena
--
-- *****************************************************************

DECLARE
  l_cOut        CLOB;
  l_vtimestamp  VARCHAR2(100) := TO_CHAR(SYSTIMESTAMP, 'YYYYMMDD_HH24MISS');
  l_vTableName  VARCHAR2(100) := '';
  l_vTablePatt  VARCHAR2(100) := '';
  l_vOldSchema  VARCHAR2(100) := '';
  l_vNewSchema  VARCHAR2(100) := '';
   
BEGIN

  l_vTableName := '';
  l_vTablePatt := '%%';
  l_vOldSchema := '';
  l_vNewSchema := '';
  
  FOR c IN (
    SELECT  TABLE_NAME
    FROM    USER_TABLES 
    WHERE   1 = 1
            AND TABLE_NAME LIKE l_vTablePatt
            OR  TABLE_NAME = l_vTableName
  )
  LOOP
    l_cOut := ''; 
  
    SELECT  DBMS_METADATA.GET_DDL('TABLE', u.table_name) || ';'
    INTO    l_cOut 
    FROM    USER_TABLES u
    WHERE   TABLE_NAME = c.TABLE_NAME;  
     
    -- optionally, replaces schema name
    IF l_vOldSchema IS NOT NULL AND l_vNewSchema IS NOT NULL THEN
      l_cOut := REPLACE(l_cOut, 
                        'CREATE TABLE "' || l_vOldSchema || '".', 
                        'CREATE TABLE "' || l_vNewSchema || '".');    
    END IF;

    -- prints DDL
    DBMS_OUTPUT.PUT_LINE(l_cOut);
  END LOOP;
END;  
