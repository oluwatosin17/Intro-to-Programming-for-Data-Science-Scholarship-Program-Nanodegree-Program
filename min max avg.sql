#When was the earliest order ever placed? You only need to return the date.
select min(occurred_at)
from ns.orders;

#Try performing the same query as in question 1 without using an aggregation function.
select occurred_at
from ns.orders
order by 1
limit 1;

#When did the most recent (latest) web_event occur?
select max(occurred_at)
from ns.web_events;

#Try to perform the result of the previous query without using an aggregation function.
select occurred_at
from ns.web_events
order by 1 desc
limit 1;

#Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper 
#type purchased per order. Your final answer should have 6 values - one for each paper type for the average
#number of sales, as well as the average amount.
select avg(standard_amt_usd), avg(standard_qty), 
	   avg(gloss_amt_usd), avg(gloss_qty),
       avg(poster_amt_usd), avg(poster_qty)
from ns.orders;

#Via the video, you might be interested in how to calculate the MEDIAN. 
#Though this is more advanced than what we have covered so far try finding - 
#what is the MEDIAN total_usd spent on all orders?
SELECT *
FROM (SELECT total_amt_usd
      FROM ns.orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

