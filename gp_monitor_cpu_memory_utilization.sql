-- CHECK DCA CPU
AND Memory Utilization (LAST minutes) \c gpperfmon
SELECT date_trunc('minutes', ctime) ctime,
       round(max(cpu_sys)::numeric,2) AS maxcpusys,
       round(max(cpu_user)::numeric,2) AS maxcpuuser,
       round(max(cpu_idle)::numeric,2) AS maxcpuidle,
       round(avg(cpu_sys)::numeric,2) AS avgcpusys,
       round(avg(cpu_user)::numeric,2) AS avgcpuuser,
       round(avg(cpu_idle)::numeric,2) AS avgcpuidle,
       round(avg(mem_actual_used)/power(1024,3)::numeric,2) avgmemgb,
       round(min(mem_actual_used)/power(1024,3)::numeric,2) minmemgb,
       round(max(mem_actual_used)/power(1024,3)::numeric,2) maxmemgb
FROM system_history
WHERE ctime >=CURRENT_TIMESTAMP - interval '60 minutes'
GROUP BY date_trunc('minutes', ctime)
ORDER BY 1 DESC;