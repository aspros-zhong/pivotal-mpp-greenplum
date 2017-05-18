-- Check last analyze
select objname,actionname,max(statime) from pg_stat_operations 
where schemaname||'.'||objname='<schemaname.tablename>' 
group by objname,actionname
order by 3 asc;;

-- Check actual table row count and stats used in plan
select count(*) from schemaname.tablename;
select reltuples::bigint from pg_class c join pg_namespace n on n.oid=relnamespace 
where nspname||'.'||relname='<schemaname.tablename>';

-- Check table skew
select gp_segment_id,count(1) from schemaname.tablename group by 1 order by 1 ;

-- Check distribution keys on the tables

-- Run explain on the table and review the output 
