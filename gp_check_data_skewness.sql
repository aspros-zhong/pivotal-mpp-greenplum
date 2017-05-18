SELECT COUNT(*), gp_segment_id FROM <table-name> GROUP BY gp_segment_id;

SELECT 'facts' as "Table Name",max(c) as "Max Seg Rows", min(c) as "Min Seg Rows", (max(c)-min(c))*100.0/max(c) as "Percentage Difference Between Max & Min" from (SELECT count(*) c, gp_segment_id from facts group by 2) as a;

