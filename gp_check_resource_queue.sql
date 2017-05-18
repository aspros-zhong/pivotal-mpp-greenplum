-- Resource Queues in your database

SELECT pg_resqueue.oid,
       rsqname
FROM pg_catalog.pg_resqueue;

-- Resource Queue Parameter Settings

SELECT *
FROM pg_catalog.pg_resqueue_attributes;

-- Resource Queue and no assigned roles/users

SELECT a.rsqname AS "RQname",

  (SELECT ressetting
   FROM pg_resqueue_attributes b
   WHERE a.rsqname=b.rsqname
     AND resname='active_statements') AS "ActiveStatment",

  (SELECT ressetting
   FROM pg_resqueue_attributes b
   WHERE a.rsqname=b.rsqname
     AND resname='max_cost') AS "MaxCost",

  (SELECT ressetting
   FROM pg_resqueue_attributes b
   WHERE a.rsqname=b.rsqname
     AND resname='min_cost') AS "MinCost",

  (SELECT ressetting
   FROM pg_resqueue_attributes b
   WHERE a.rsqname=b.rsqname
     AND resname='cost_overcommit') AS "CostOvercommit",

  (SELECT ressetting
   FROM pg_resqueue_attributes b
   WHERE a.rsqname=b.rsqname
     AND resname='memory_limit') AS "MemoryLimit",

  (SELECT ressetting
   FROM pg_resqueue_attributes b
   WHERE a.rsqname=b.rsqname
     AND resname='priority') AS "Priority",

  (SELECT count(*)
   FROM pg_resqueue x,
        pg_roles y
   WHERE x.oid=y.rolresqueue
     AND a.rsqname=x.rsqname) AS "RQAssignedUsers"
FROM
  (SELECT DISTINCT rsqname
   FROM pg_resqueue_attributes) a
ORDER BY 1;

-- Resource Queue assigned to Group roles. Information purpose only - Group role resource queue not enforced

SELECT rrrsqname rqname,
       rrrolname AS username
FROM gp_toolkit.gp_resq_role
WHERE rrrolname IN
    (SELECT DISTINCT rolname AS group_role
     FROM pg_roles
     JOIN pg_auth_members ON (pg_roles.oid=pg_auth_members.roleid));

-- Viewing the Roles Assigned to a Resource Queue

SELECT rolname,
       rsqname
FROM pg_roles,
     gp_toolkit.gp_resqueue_status
WHERE pg_roles.rolresqueue=gp_toolkit.gp_resqueue_status.queueid;

-- Viewing the Waiting Queries for a Resource Queue

SELECT *
FROM gp_toolkit.gp_locks_on_resqueue
WHERE lorwaiting='true';