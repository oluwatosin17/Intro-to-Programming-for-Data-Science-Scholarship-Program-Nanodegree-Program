#Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
select a.name name, o.occurred_at
from ns.orders o
inner join ns.accounts a
on a.id = o.account_id
order by 2
limit 1;

#Find the total sales in usd for each account. You should include two columns -
# the total sales for each company's orders in usd and the company name.
select sum(total) total_sales, a.name 'name of company'
from ns.orders o
inner join ns.accounts a
on a.id = o.account_id
group by 2;

#Via what channel did the most recent (latest) web_event occur, which account 
#was associated with this web_event? Your query should return only three values 
#- the date, channel, and account name.
select w.occurred_at, w.channel, a.name
from ns.web_events w
inner join ns.accounts a
on a.id = w.account_id
order by 1 desc
limit 1;


#Find the total number of times each type of channel from the web_events was used. 
#Your final table should have two columns - the channel and the number of times the channel was used.
select w.channel channel, count(*) 'number of times the channel was used'
from ns.web_events w 
group by 1;


#Who was the primary contact associated with the earliest web_event?
select a.primary_poc, w.occurred_at
from ns.web_events w
inner join ns.accounts a
on w.account_id = a.id
order by 2
limit 1;

#What was the smallest order placed by each account in terms of total usd. Provide only two columns
# - the account name and the total usd. Order from smallest dollar amounts to largest.
select a.name, min(total_amt_usd)
from ns.orders o
inner join ns.accounts a
on o.account_id = a.id 
group by 1
order by 2;

#Find the number of sales reps in each region. Your final table should have two columns - 
#the region and the number of sales_reps. Order from fewest reps to most reps.
select r.name region, count(s.id) "number of sales_reps"
from ns.sales_rep s
inner join ns.region r
on s.region_id = r.id
group by 1
order by 2;
