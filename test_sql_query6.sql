with cohort_users as (
	select 
  		distinct id as id,
  		date_trunc(date(created_at), day) as created_at
  	from prod.users_view
	where 
  		(cohort = {COHORT} or {COHORT} = 'None' and cohort is null) 
  		and (created_at is not null)  -- exclude nan values from calculation
),

last_subscription as(
	select 
		user_id,
	  	date_trunc(date(original_timestamp), day) as original_timestamp
	from 
  		(select 
	  		*, 
	  		row_number() over (partition by user_id order by original_timestamp desc) as stamp_number -- only last
		from prod.cdndaily_view) as cdd
	where 
  		stamp_number = 1 
  		and original_timestamp is not null),  -- exclude NaN values

cdn as(
  	select 
  		user_id,
  		date_diff(original_timestamp, created_at, day) as user_lifetime, -- is 'created_at' the right starting point?
  		created_at,
  		original_timestamp
  	from cohort_users as ch
	inner join last_subscription as ls on ch.id = ls.user_id
	order by original_timestamp desc)
  
 -- select distinct user_id, date_trunc(date(original_timestamp), day) as day
--from cdn
--group by user_id, day

select concat(round(avg(user_lifetime)), ' days')
from cdn
