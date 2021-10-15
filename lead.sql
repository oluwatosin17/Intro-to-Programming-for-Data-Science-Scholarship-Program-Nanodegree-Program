select account_id, standard_sum,
 LEAD(standard_sum) OVER (ORDER BY standard_sum) lag_,
 Lead(standard_sum) OVER (ORDER BY standard_sum) - standard_sum AS lead_difference
from 
(SELECT account_id, 
SUM(standard_qty) AS standard_sum
FROM ns.orders
GROUP BY 1) sub
