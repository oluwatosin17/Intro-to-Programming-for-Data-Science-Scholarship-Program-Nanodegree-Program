select id,
account_id, occurred_at, standard_qty,
ntile(4) over (order by standard_qty) as quartile,
ntile(5) over (order by standard_qty) as quintile,
ntile(100) over (order by standard_qty) as percentile
from ns.orders
order by standard_qty desc;
#Use the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders. 
#Your resulting table should have the account_id, the occurred_at time for each order, the total amount of standard_qty 
#paper purchased, and one of four levels in a standard_quartile column.
select id,
account_id, occurred_at, (standard_qty), 
ntile(4) over (order by standard_qty) as quartile
from ns.orders
order by standard_qty desc;

#Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty 
#for their orders. Your resulting table should have the account_id, the occurred_at time for each order, 
#the total amount of gloss_qty paper purchased, and one of two levels in a gloss_half column.
select id,
account_id, occurred_at, (gloss_qty), 
ntile(4) over (order by gloss_qty) as quartile,
ntile(5) over (order by gloss_qty) as quintile
from ns.orders
order by gloss_qty desc;

#Use the NTILE functionality to divide the orders for each account into 100 levels 
#in terms of the amount of total_amt_usd for their orders. Your resulting table should have the account_id, 
#the occurred_at time for each order, the total amount of total_amt_usd paper purchased, and one of 100
# levels in a total_percentile column.

select 
account_id, occurred_at, total_amt_usd, 
ntile(100) over (order by gloss_qty) as quartile
from ns.orders
order by account_id desc;