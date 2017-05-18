-- List the tables that are partitioned and provide the total number of partitions and sub partitions on a table.

SELECT distinct m.schemaname||'.'||m.tablename "Relation Name", 
 CASE 
 WHEN p.tolpart IS NULL THEN 0
 ELSE p.tolpart
 END AS "Total Parition", 
 CASE 
 WHEN s.tolsubpart IS NULL THEN 0
 ELSE s.tolsubpart
 END AS  "Total Subpartitions"
FROM pg_partitions m 
LEFT JOIN (SELECT schemaname,tablename,count(*) tolpart FROM pg_partitions WHERE parentpartitiontablename IS NULL group by schemaname,tablename ) p
ON p.schemaname=m.schemaname AND p.tablename=m.tablename
LEFT JOIN (SELECT schemaname,tablename,count(*) tolsubpart FROM pg_partitions WHERE parentpartitiontablename IS NOT NULL group by schemaname,tablename) s
ON s.schemaname=m.schemaname
AND s.tablename=m.tablename
ORDER BY 1;
