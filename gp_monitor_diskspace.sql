
-- Check storage utilization per segment server
\c gpperfmon
SELECT ctime,
       hostname,
       filesystem,
       pg_size_pretty(total_bytes) AS total_bytes,
       pg_size_pretty(bytes_used) AS used_bytes,
       pg_size_pretty(bytes_available) AS avail_bytes,
       (round((bytes_used * 100)/total_bytes::numeric,2))||'%' AS pct_used
FROM diskspace_now
ORDER BY hostname,
         filesystem, (round((bytes_used * 100)/total_bytes::numeric,2)) DESC;

-- Disk Space Availability

SELECT total_gb,
       used_gb,
       available_gb,
       round((used_gb*100)/total_gb::numeric,2)||'%' AS pct_used,
       round((available_gb*100)/total_gb::numeric,2)||'%' AS pct_available
FROM
  (SELECT sum(round((bytes_used / power(1024,3))::numeric,2)) AS used_gb,
          sum(round((bytes_available / power(1024,3))::numeric,2)) AS available_gb,
          sum(round((total_bytes / power(1024,3))::numeric,2)) AS total_gb
   FROM
     (SELECT date_trunc('hour', ctime) ctime_hour,
             to_char(ctime, 'Month') AS "month",
             to_char(ctime, 'ddd') AS "day",
             to_char(ctime, 'Day') AS weekday,
             to_char(ctime, 'hh24') AS "hour",
             hostname,
             filesystem,
             bytes_used,
             bytes_available,
             total_bytes,
             row_number() over (partition BY to_char(ctime, 'ddd'), hostname
                                ORDER BY total_bytes DESC) space_used_rank
      FROM diskspace_now
      WHERE filesystem IN ('/data1',
                           '/data2')
        AND hostname LIKE 'sdw%' ) a
   WHERE space_used_rank = 1
   GROUP BY DAY) AS b;