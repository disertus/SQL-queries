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


--lifetime total
with lifetime_per_paid_user as (
  	select 
	  	distinct p.id,
		date_diff(max(date(period_end)), min(date(period_start)), month) as user_lifetime
	from stripe.invoices as i
  	inner join stripe.charges as c using (customer)
  	inner join prod.users_view as p on i.customer = p.stripe_id -- users not divided into cohorts
	where 
		(period_start, period_end) is not null
  		and c.amount > 100
  		and c.refunded = false
	group by p.id
	having user_lifetime > 0)

select round(avg(user_lifetime), 2)
from lifetime_per_paid_user
