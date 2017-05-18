$psql -c 'SHOW ALL;'

select category,name,setting,unit,context,source,min_val,max_val,short_desc,extra_desc
from pg_settings
order by category;
