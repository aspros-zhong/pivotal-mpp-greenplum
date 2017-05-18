-- Database Size

SELECT datname,
       pg_size_pretty(pg_database_size(datname)) AS SIZE
FROM pg_database;

-- Schema Size

SELECT sosdnsp AS SchemaName,
       round(sosdschematablesize/power(1024,3)::numeric,2) AS "Table Size (GB)",
       round(sosdschemaidxsize/power(1024,3)::numeric,2) AS "Indx Size GB (GB)",
       round((sosdschematablesize + sosdschemaidxsize)/power(1024,3)::numeric,2) AS "Total Schema Size (GB)"
FROM gp_toolkit.gp_size_of_schema_disk
ORDER BY 4 DESC ;

-- Table Size

SELECT pg_size_pretty(pg_total_relation_size('public.sales'));