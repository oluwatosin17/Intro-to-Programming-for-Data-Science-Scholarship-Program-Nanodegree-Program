select account_id, standard_sum,
 LAG(standard_sum) OVER (ORDER BY standard_sum) lag_,
 standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference
from 
(SELECT account_id, 
SUM(standard_qty) AS standard_sum
FROM ns.orders
GROUP BY 1) sub

