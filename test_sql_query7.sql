with cohort_users as (
	select *
  	from prod.users_view
	where 
  		(cohort = {COHORT} or {COHORT} = 'None' and cohort is null) 
  		and (created_at is not null)  -- exclude nan values from calculation
),

lifetime_per_user as (select 
	  	distinct customer, 
		date_diff(max(date(period_end)), min(date(period_start)), day) as user_lifetime
	from stripe.invoices
	where (period_start, period_end) is not null
	group by customer)

select avg(user_lifetime)
from lifetime_per_user as l
where l.customer in (select stripe_id from cohort_users)
