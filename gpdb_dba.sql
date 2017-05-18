-- list databases

SELECT datname,
       datacl
FROM pg_database;

-- List Schemas

SELECT nspname
FROM pg_catalog.pg_namespace;

-- List User Roles

SELECT usename AS username
FROM pg_user;

-- List Group Roles

SELECT DISTINCT rolname AS group_role
FROM pg_roles
JOIN pg_auth_members ON (pg_roles.oid=pg_auth_members.roleid);

-- Role Resource Queue Mapping

SELECT *
FROM gp_resq_role ;