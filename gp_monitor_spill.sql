-- Check spill size per query

SELECT procpid,
       sum(SIZE)/power(1024,3),
       avg(SIZE)/power(1024,3)
FROM gp_toolkit.gp_workfile_usage_per_query
GROUP BY procpid;

-- Check spill size per segment

SELECT *
FROM gp_toolkit.gp_workfile_usage_per_segment;