SELECT account_id, 
CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
		ELSE standard_amt_usd/standard_qty END AS unit_price
FROM ns.orders
LIMIT 10;

select total
from ns.orders;

select 
case when o.total > 500 then 'Over 500'
else '500 or under' end as total_group,
count(*) as order_count
from ns.orders o
group by 1;

#Write a query to display for each order, the account ID, total amount of the order, and 
#the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
select a.id, o.total_amt_usd,  
case when o.total_amt_usd >= 3000 
then 'Large'
else 'Small'
end as order_group
from ns.orders o
inner join ns.accounts a
on o.account_id = a.id
group by 1,2;

#Write a query to display the number of orders in each of three categories, based on the total number 
#of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
select 
case 
when o.total < 1000  then 'Less than 1000'
when o.total >=1000 and o.total <= 2000 then 'Between 1000 and 2000'
else 'At Least 2000' end as total_group,
count(*) as order_count
from ns.orders o
group by 1;


#We would like to understand 3 different levels of customers based on the amount associated with 
#their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) 
#greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level 
#is anyone under 100,000 usd. Provide a table that includes the level associated with each account. 
#You should provide the account name, the total sales of all orders for the customer, and the level. 
#Order with the top spending customers listed first.

select a.name, sum(o.total_amt_usd),
case 
when sum(o.total_amt_usd) < 100000 then 'low-level'
when sum(o.total_amt_usd) >=100000 and sum(o.total_amt_usd) <= 200000 then 'medium-level'
else 'high-level' end as lifetime_grouping 
from ns.orders  o
join ns.accounts a
on o.account_id = a.id
group by 1
order by 2 desc;


#We would now like to perform a similar calculation to the first, but we want to obtain the total
# amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. 
#Order with the top spending customers listed first.
select a.name, sum(o.total_amt_usd),date_part('year',occurred_at) date,
case 
when sum(o.total_amt_usd) < 100000 then 'low-level'
when sum(o.total_amt_usd) >=100000 and sum(o.total_amt_usd) <= 200000 then 'medium-level'
else 'high-level' end as lifetime_grouping 
from orders  o
join accounts a
on o.account_id = a.id
where date_part('year',occurred_at) between '2016' and '2017'
group by 1,3
order by 2 desc;

#We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. 
#Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if 
#they have more than 200 orders. Place the top sales people first in your final table.
select s.name name, count(*) num_ord,
	case
    when count(*) > 200 then 'top'
    else 'low' end as topsales
from ns.sales_rep s
join ns.accounts a
on s.id = a.sales_rep_id
join ns.orders o
on a.id = o.account_id
group by 1
order by 2 desc;

#The previous didn't account for the middle, nor the dollar amount associated with the sales. 
#Management decides they want to see these characteristics represented as well. We would like 
#to identify top performing sales reps, which are sales reps associated with more than 200 orders 
#or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000
# in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, 
#and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar 
#amount of sales first in your final table. You might see a few upset sales people by this criteria!

select s.name name, count(*) num_ord, sum(o.total_amt_usd),
   CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
from ns.sales_rep s
join ns.accounts a
on s.id = a.sales_rep_id
join ns.orders o
on a.id = o.account_id
group by 1
order by 1,2 desc;
