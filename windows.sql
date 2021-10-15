select standard_qty, sum(standard_qty) over (order by occurred_at) as running_total
from ns.orders;

select standard_amt_usd, sum(standard_amt_usd) 
over (order by occurred_at) running_total
from ns.orders;

SELECT standard_amt_usd, date_trunc('year', occurred_at),
       SUM(standard_amt_usd) OVER (partition by date_trunc('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders;

select id, account_id, occurred_at,
row_number() over (order by id) as row_num
from ns.orders;

select id, account_id, occurred_at,
row_number() over (order by occurred_at ) as row_num
from ns.orders;

select id, account_id, occurred_at,
row_number() over (partition by account_id order by occurred_at ) as row_num
from ns.orders;

select id, account_id, occurred_at,
rank() over (partition by account_id order by occurred_at ) as rank_
from ns.orders;

select id, account_id, occurred_at,
dense_rank() over (partition by account_id order by occurred_at ) as rank_
from ns.orders;


#Select the id, account_id, and total variable from the orders table, then create a column called 
#total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. 
#Your final table should have these four columns.

select id, account_id, total,
rank() over (partition by account_id order by total desc) as total_amount
from ns.orders;

