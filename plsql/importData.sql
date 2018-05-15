---------------
--
---------------
SELECT
  'INSERT INTO ' || t.TABLE_NAME ||  ' (' || val.column_names || ')' ||
  chr(10) || ' SELECT * FROM ' ||
  t.TABLE_NAME || chr(10) || '; COMMIT;'
FROM USER_TABLES t
JOIN (
  SELECT
    table_name,
    LISTAGG (column_name, ', ') WITHIN GROUP(ORDER BY column_id) column_names
  FROM (
    SELECT table_name, column_name, column_id
    FROM ALL_TAB_COLUMNS
    WHERE SUBSTR(TABLE_NAME,1,1) =  'X'
  )
  GROUP BY
   table_name
  ORDER BY table_name
) val
ON t.table_name = val.table_name
ORDER BY t.table_name
;
