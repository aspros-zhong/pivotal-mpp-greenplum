SELECT datname AS "Db name",
       usename AS "User name",
       procpid AS "Pid",
       sess_id AS "SessionID",
       waiting AS "Waiting",
       client_addr AS "client Addr",
       application_name AS "App Name",
       now() - query_start AS "Duration",
       substring(current_query,1,40) AS "Current Query"
FROM pg_stat_activity
WHERE current_query!='<IDLE>'
ORDER BY "Duration" DESC;
