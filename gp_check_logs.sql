-- For last 30 minutes excluding gpadmin and gpmon

select logsession,logtime,loguser,logmessage
from gp_toolkit.__gp_log_master_ext 
where logtime>current_timestamp-interval '30 minutes' 
and loguser not like 'gp%' limit 2;

-- For a specific user name

select logsession,logtime,loguser,logmessage 
from gp_toolkit.__gp_log_master_ext 
where logtime>current_timestamp-interval '30 minutes' 
and lower(loguser) ='<username>';

-- For list of user name

select logsession,logtime,loguser,logmessage 
from gp_toolkit.__gp_log_master_ext 
where logtime>current_timestamp-interval '30 minutes' 
and loguser in ('<username1>', '<username2>');

-- For specific session is

select logsession,logtime,loguser,logmessage 
from gp_toolkit.__gp_log_master_ext 
where logtime>current_timestamp-interval '30 minutes' 
and  logsession='con<session id>' ;

--For a specific message

select logsession,logtime,loguser,logmessage
from gp_toolkit.__gp_log_master_ext 
where logtime>current_timestamp-interval '30 minutes' 
and upper(logmessage) like %SELECT%' limit 2;
