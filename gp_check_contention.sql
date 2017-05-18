SELECT locktype,
       DATABASE,
       c.relname,
       l.relation,
       l.transactionid,
       l.transaction,
       l.pid,
       l.mode,
       l.granted,
       substr(a.current_query,1,30)
FROM pg_locks l,
     pg_class c,
     pg_stat_activity a
WHERE l.relation=c.oid
  AND l.pid=a.procpid
ORDER BY c.relname;
