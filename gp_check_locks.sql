SELECT usename,
       COUNT(DISTINCT pid)
FROM pg_locks l
JOIN pg_stat_activity a ON (a.procpid=l.pid)
WHERE l.granted IS FALSE
GROUP BY 1
ORDER BY COUNT DESC;


SELECT *
FROM pg_locks
WHERE pid IN
    (SELECT procpid
     FROM pg_stat_activity
     WHERE current_query NOT LIKE '<IDLE>')
  AND NOT GRANT
