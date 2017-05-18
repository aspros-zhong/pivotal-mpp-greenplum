
-- Checking distribution keys

SELECT pgn.nspname AS schemaname,
       pgc.relname AS tablename,
       pga.attname AS distributionkey
FROM
  (SELECT gdp.localoid,
          CASE
              WHEN (Array_upper(gdp.attrnums, 1) > 0) THEN Unnest(gdp.attrnums)
              ELSE NULL
          END AS attnum
   FROM gp_distribution_policy gdp
   ORDER BY gdp.localoid) AS distrokey
INNER JOIN pg_class AS pgc ON distrokey.localoid = pgc.oid
INNER JOIN pg_namespace pgn ON pgc.relnamespace = pgn.oid
LEFT OUTER JOIN pg_attribute pga ON distrokey.attnum = pga.attnum
AND distrokey.localoid = pga.attrelid
ORDER BY pgn.nspname,
         pgc.relname;
