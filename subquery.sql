#Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
select t3.sales_rep, t3.region, t3.total_amount
from
(select region, max(total_amount) total_amount
from
(select s.name sales_rep, r.name region, sum(total_amt_usd) total_amount
from ns.sales_rep s
join ns.accounts a 
on s.id = a.sales_rep_id
join ns.orders o
on a.id = o.account_id
join ns.region r
on s.region_id = r.id
group by 1,2
order by 3 desc) t1
group by 1) t2
join 
		(select s.name sales_rep, r.name region, sum(total_amt_usd) total_amount
		from ns.sales_rep s
		join ns.accounts a 
		on s.id = a.sales_rep_id
		join ns.orders o
		on a.id = o.account_id
		join ns.region r
		on s.region_id = r.id
		group by 1,2
		order by 3 desc) t3
on t2.region = t3.region and  t2.total_amount = t3.total_amount;


#For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?

select t3.region, count(*)
from
(select region, max(total_amount) total_amount
from
(select r.name region, sum(o.total_amt_usd) total_amount
from ns.region r
join ns.sales_rep s
on r.id = s.region_id
join ns.accounts a 
on s.id = a.sales_rep_id
join ns.orders o
on a.id =  o.account_id
group by 1) t1) t2
join 
(select o.id orders, r.name region, sum(o.total_amt_usd) total_amount
from ns.region r
join ns.sales_rep s
on r.id = s.region_id
join ns.accounts a 
on s.id = a.sales_rep_id
join ns.orders o
on a.id =  o.account_id
group by 1, 2) t3
on t3.region = t2.region;

#How many accounts had more total purchases than the account name which has bought the 
#most standard_qty paper throughout their lifetime as a customer?

select a.name name, sum(o.total) total
from ns.orders o
join ns.accounts a
on o.account_id = a.id
group by 1
having sum(o.total) >  (select total 
	from (select a.name name, sum(standard_qty) std, sum(total) total
			from ns.orders o
			join ns.accounts a
			on o.account_id = a.id
			group by 1
			order by 2 desc
			limit 1) tb1);
            
#For the customer that spent the most (in total over their lifetime as a customer) 
#total_amt_usd, how many web_events did they have for each channel?

select tb2.name, tb2.channel, tb2.num
from
(select a.name name, sum(o.total_amt_usd) total
from ns.orders o
join ns.accounts a 
on o.account_id = a.id
group by 1
order by 2 desc
limit 1) tb1
join
(select a.name name, w.channel channel, count(*) num
from ns.web_events w
join ns.accounts a
on w.account_id = a.id
group by 1,2) tb2
on tb2.name = tb1.name
group by 1,2
order by 3 desc;


#What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

select avg(top_spending) lifetime_avg_amount
from
(select a.name, sum(o.total_amt_usd) top_spending
from ns.accounts a
join ns.orders o
on a.id = o.account_id
group by 1
order by 2 desc
limit 10) tb1;



#What is the lifetime average amount spent in terms of total_amt_usd, 
#including only the companies that spent more per order, on average, than the average of all orders.

select avg(avg_amount) avg_amount
from
(select a.name name, avg(o.total_amt_usd) avg_amount
from ns.accounts a
join ns.orders o
on a.id = o.account_id
group by 1
having avg(o.total_amt_usd) >
(select avg(o.total_amt_usd)
from ns.accounts a
join ns.orders o
on a.id = o.account_id))tb1
