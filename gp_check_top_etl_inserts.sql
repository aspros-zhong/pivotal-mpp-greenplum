\c gpperfmon
\x
\t
select tfinish-tstart as elapsed,username,rsqname,query_text 
from queries_history 
where upper(substr(query_text,1,20)) like '%INSERT%' 
and ctime>'2016-01-01' order by 1 desc 
limit 25 ;

select tfinish-tstart as elapsed,username,rsqname,substr(query_text,1,20) as query_text 
from queries_history 
where upper(substr(query_text,1,20)) like '%INSERT%' 
and ctime>'2016-01-01' 
order by 1 desc limit 25 ;
