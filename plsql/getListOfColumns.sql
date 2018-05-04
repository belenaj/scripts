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
 
BEGIN

  l_vTableName := '';
    
  SELECT 
    RTRIM(XMLAGG(XMLELEMENT(E, column_name,', ')
    .EXTRACT('//text()') ORDER BY column_id)
    .GetClobVal(),',')  
  INTO l_cOut
  FROM (
    SELECT 
      column_name,
      column_id
    FROM  ALL_TAB_COLUMNS
    WHERE TABLE_NAME = l_vTableName
  ) s;
  
  -- removes last comma and new line char
  l_cOut := SUBSTR(l_cOut, 1, LENGTH(l_cOut) - 2);
  
  -- prints list of columns in order
  DBMS_OUTPUT.PUT_LINE(l_cOut);
END;