-- CHECK activity
SELECT usename,
       sess_id,
       query_start,
       now()-query_start AS elapsed,
       procpid,
       substr(current_query,1,30),
       waiting
FROM pg_stat_activity
WHERE current_query NOT LIKE '<IDLE>'
ORDER BY 4 DESC;

--check_user_activity_by_database

SELECT datname,
       usename,
       count(*)
FROM pg_catalog.pg_stat_activity
GROUP BY datname,
         usename
ORDER BY datname,
         usename;

-- Check sessins started and idle for more than 30 minutes

SELECT *
FROM pg_stat_activity
WHERE current_query LIKE '<IDLE>'
  AND backend_start<now()-interval '30 minutes';

-- Check Waiting Session

SELECT usename,
       sess_id,
       query_start,
       now()-query_start AS elapsed,
       current_query,
       waiting
FROM pg_stat_activity
WHERE waiting
ORDER BY 4 DESC;
Switched to HTTPS



