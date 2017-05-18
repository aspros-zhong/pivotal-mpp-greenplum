-- CHECK LOAD
AND SWAP activity \c gpperfmon
SELECT date_trunc('minutes', ctime) ctime_minutes,
       round(avg(load0)::numeric,2) AS cpuavgload1minute,
       round(avg(load1)::numeric,2) AS cpuavgload5minute,
       round(avg(load2)::numeric,2) AS cpuavgload15minute,
       round(avg(swap_used)/power(1024,3)::numeric,2) avgswapgb,
       round(min(swap_used)/power(1024,3)::numeric,2) minswapgb,
       round(max(swap_used)/power(1024,3)::numeric,2) maxswapdgb
FROM system_history
WHERE ctime >=CURRENT_TIMESTAMP - interval '60 minutes'
GROUP BY date_trunc('minutes', ctime)
ORDER BY 1 DESC;
