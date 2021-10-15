#Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH t1 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM ns.sales_rep s
   JOIN ns.accounts a
   ON a.sales_rep_id = s.id
   JOIN ns.orders o
   ON o.account_id = a.id
   JOIN ns.region r
   ON r.id = s.region_id
   GROUP BY 1,2
   ORDER BY 3 DESC),
   t2 AS (
   SELECT region_name, MAX(total_amt) total_amt
   FROM t1
   GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;

#How many accounts had more total purchases than the account name which has bought 
#the most standard_qty paper throughout their lifetime as a customer?

with tb1 as (
select a.name name, sum(standard_qty) std_qty, sum(o.total) total
from ns.orders o
join ns.accounts a
on o.account_id = a.id
group by 1
order by 2 desc
limit 1),

 tb2 as ( select a.name name,  sum(o.total) total
from ns.orders o
join ns.accounts a
on o.account_id = a.id
group by 1
having sum(o.total) > (select total from tb1)  )

select *
from tb2;

#For the region with the largest sales total_amt_usd, 
#how many total orders were placed?

with tb1 as (select r.name region, sum(o.total_amt_usd) total
from ns.region r
join ns.sales_rep s
on r.id = s.region_id
join ns.accounts a
on s.id = a.sales_rep_id
join ns.orders o
on a.id = o.account_id
group by 1
order by 2 desc
limit 1),

tb2 as (select o.id 
from ns.region r
join ns.sales_rep s
on r.id = s.region_id
join ns.accounts a
on s.id = a.sales_rep_id
join ns.orders o
on a.id = o.account_id
where r.name = (select region from tb1))

select count(*) number_of_counts
from tb2;

#For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd,
# how many web_events did they have for each channel?

with tb1 as (select a.name account_name, sum(o.total_amt_usd) total
from ns.orders o
join ns.accounts a 
on o.account_id = a.id
group by 1
order by 2 desc
limit 1),

tb2 as ( select a.name name, w.channel channel, count(*) count
from ns.web_events w
join ns.accounts a
on w.account_id = a.id
where a.name  = (select account_name from tb1 )
group by 1,2
order by 3 desc)

select name, channel, count
from tb2
group by 1,2;

#What is the lifetime average amount spent in terms of total_amt_usd 
#for the top 10 total spending accounts?

with tb1 as (select a.name name, sum(o.total_amt_usd) total
from ns.orders o
join ns.accounts a
on o.account_id = a.id
group by 1
order by 2 desc
limit 10)

select avg(total) total
from tb1;

#What is the lifetime average amount spent in terms of total_amt_usd, 
#including only the companies that spent more per order, on average, 
#than the average of all orders.

with tb1 as (select avg(o.total_amt_usd) avg_amt
from ns.accounts a
join ns.orders o
on a.id = o.account_id),

tb2 as (select a.name name, avg(o.total_amt_usd) avg_amt
from ns.accounts a
join ns.orders o
on a.id = o.account_id
group by 1
having avg(o.total_amt_usd) > ( select avg_amt from tb1)
order by 2 desc)

select avg(avg_amt)
from tb2











