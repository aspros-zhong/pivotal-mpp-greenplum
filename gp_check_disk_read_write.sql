\c gpperfmon
SELECT date_trunc('minutes', ctime) ctime_minutes,
       round(avg(disk_rb_rate)/power(1024,1)::numeric,2) avgdiskreadpersec_kb,
       round(avg(disk_wb_rate)/power(1024,1)::numeric,2) avgdiskwritepersec_kb,
       round(avg(disk_ro_rate)::numeric,2) avgdiskreadoppersec,
       round(avg(disk_wo_rate)::numeric,2) avgdiskwriteoppersec
FROM system_history
WHERE ctime >=CURRENT_TIMESTAMP - interval '60 minutes'
GROUP BY date_trunc('minutes', ctime)
ORDER BY 1 DESC;