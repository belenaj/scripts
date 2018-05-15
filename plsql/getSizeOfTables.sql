-- Tables + Size MB
select owner, table_name, round((num_rows*avg_row_len)/(1024*1024)) MB 
from all_tables 
where owner not like 'SYS%'  -- Exclude system tables.
and num_rows > 0  -- Ignore empty Tables.
order by MB desc -- Biggest first.
;


--Tables + Rows
select owner, table_name, num_rows
 from all_tables 
where owner not like 'SYS%'  -- Exclude system tables.
and num_rows > 0  -- Ignore empty Tables.
order by num_rows desc -- Biggest first.
;