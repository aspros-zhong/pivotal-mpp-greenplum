
-- Check top 25 largest table (in size) in GPDB

SELECT soatischemaname AS schemaname,
       soatitablename AS tablename,
       round(max(soatisize)/power(1024,3)::integer,3) sizeGB
FROM gp_toolkit.gp_size_of_all_table_indexes
GROUP BY soatischemaname,
         soatitablename
ORDER BY 3 DESC
LIMIT 25;
