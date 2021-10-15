#For each account, determine the average amount of each type of paper they purchased across their orders.
#Your result should have four columns - one for the account name and one for the average quantity purchased for each of the
#paper types for each account.
select a.name name, avg(o.standard_qty) std_qty, avg(o.poster_qty) pos_qty, avg(o.gloss_qty) glo_qty
from ns.orders o
inner join ns.accounts a
on o.account_id = a.id
group by 1;

#For each account, determine the average amount spent per order on each paper type. 
#Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
select a.name name, avg(o.standard_amt_usd) std_qty, avg(o.poster_amt_usd) pos_qty, avg(o.gloss_amt_usd) glo_qty
from ns.orders o
inner join ns.accounts a
on o.account_id = a.id
group by 1;


#Determine the number of times a particular channel was used in the web_events table for each sales rep. 
#Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. 
#Order your table with the highest number of occurrences first.
select s.name sales_rep, w.channel channel, count(*) "number of times"
from ns.web_events w
inner join ns.accounts a
on w.account_id = a.id
inner join ns.sales_rep s
on a.sales_rep_id = s.id
group by 1,2
order by 3 desc;

#Determine the number of times a particular channel was used in the web_events table for each region. 
#Your final table should have three columns - the region name, the channel, and the number of occurrences. 
#Order your table with the highest number of occurrences first.
select r.name region_name, w.channel channel_name, count(*) number_of_occurrences
from ns.web_events w
inner join ns.accounts a
on w.account_id = a.id
inner join ns.sales_rep s
on a.sales_rep_id = s.id
inner join ns.region r
on s.region_id = r.id
group by 1,2
order by 3 desc;