-- *****************************************************************
-- Description: Generate INSERT INTO SELECT Statements to dump
-- the data from one schema to another for the same tablenames and
-- table structures
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
  l_cColumns    CLOB;
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
    -- reset working variables
    l_cOut      := ''; 
    l_cColumns  := ''; 
    
    -- get list of columns
    SELECT 
      RTRIM(XMLAGG(XMLELEMENT(E, column_name,', ')
      .EXTRACT('//text()') ORDER BY column_id)
      .GetClobVal(),',')  
    INTO l_cColumns
    FROM (
      SELECT 
        column_name,
        column_id
      FROM  USER_TAB_COLUMNS
      WHERE TABLE_NAME = c.TABLE_NAME
    ) s;
  
    -- removes last comma and new line char
    l_cColumns := SUBSTR(l_cColumns, 1, LENGTH(l_cColumns) - 2);
  
    SELECT 'INSERT INTO ' || l_vNewSchema || '.' || c.TABLE_NAME || CHR(10) ||
           '(' || l_cColumns || ')' || CHR(10) ||
           'SELECT ' || l_cColumns  || CHR(10) ||
           'FROM '   || l_vOldSchema || '.' || c.TABLE_NAME  || ';' || CHR(10) ||
           'COMMIT;' || CHR(10)
    INTO    l_cOut 
    FROM    DUAL;
  
     -- prints DDL
    DBMS_OUTPUT.PUT_LINE(l_cOut);
  END LOOP;
END;  
    