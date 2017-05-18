--check_current_activity
-- select * from pg_stat_activity;
SELECT datid, datname, procpid, sess_id, usesysid, usename, waiting, query_start, backend_start, xact_start, application_name, current_query FROM pg_stat_activity ;

 --check_user_activity_by_database
select datname,usename,count(*) from pg_catalog.pg_stat_activity group by datname,usename order by datname,usename;

 -- Check sessins started and idle for more than 60 minutes
select * from pg_stat_activity where substring(current_query,2,4)='IDLE' and backend_start<now()-interval '1 hour';
