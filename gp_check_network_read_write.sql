\c gpperfmon
SELECT date_trunc('minutes', ctime) ctime_minutes,
       round(avg(net_rb_rate)::numeric,2) avgnetrbps,
       round(avg(net_wb_rate)::numeric,2) avgnetwb,
       round(avg(net_rp_rate)::numeric,2) avgpacketpersecforro,
       round(avg(net_wb_rate)::numeric,2) avgpacketpersecforwo
FROM system_history
WHERE ctime >=CURRENT_TIMESTAMP - interval '60 minutes'
GROUP BY date_trunc('minutes', ctime)
ORDER BY 1 DESC;
