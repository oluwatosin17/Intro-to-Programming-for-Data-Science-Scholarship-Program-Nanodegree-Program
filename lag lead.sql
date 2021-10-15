#Modify Derek's query from the previous video in the SQL Explorer below to perform this analysis. 
#You'll need to use occurred_at and total_amt_usd in the orders table along with LEAD to do so. In your query results, 
#there should be four columns: occurred_at, total_amt_usd, lead, and lead_difference.

SELECT occurred_at, total_amt_usd,
       LAG(total_amt_usd) OVER (ORDER BY occurred_at) AS lag_total,
       Lead(total_amt_usd) OVER (ORDER BY occurred_at) AS lead_total,
       total_amt_usd - LAG(total_amt_usd) OVER (ORDER BY occurred_at) AS lag_difference_total,
       LEAD(total_amt_usd) OVER (ORDER BY  occurred_at) - total_amt_usd AS lead_difference       
FROM (
SELECT occurred_at, sum(total_amt_usd) total_amt_usd,
       SUM(standard_qty) AS standard_sum
  FROM ns.orders 
 GROUP BY 1
 ) sub;
 
 
 
 SELECT occurred_at,
       total_amt_usd,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead_,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd AS lead_difference
FROM (
SELECT occurred_at,
       SUM(total_amt_usd) AS total_amt_usd
  FROM ns.orders 
 GROUP BY 1
) sub