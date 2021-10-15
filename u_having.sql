#How many of the sales reps have more than 5 accounts that they manage?
select s.name, count(a.id)
from ns.accounts a
join ns.sales_rep s
on a.sales_rep_id = s.id
group by 1
having count(a.id) > 5
order by 2 desc;

#How many accounts have more than 20 orders?
select a.name, count(*)
from ns.accounts a
join ns.orders o
on a.id = o.account_id
group by 1
having count(*) > 20
order by 2 desc;


#Which account has the most orders?
select a.name, count(*)
from ns.accounts a
join ns.orders o
on a.id = o.account_id
group by 1
order by 2 desc
limit 1;

#Which accounts spent more than 30,000 usd total across all orders?
select a.id, a.name, o.total_amt_usd
from ns.accounts a
join ns.orders o
on a.id = o.account_id
group by 1,2
having o.total_amt_usd > 30000
order by 3 desc;

#Which accounts spent less than 1,000 usd total across all orders?
select a.id, a.name, o.total_amt_usd
from ns.accounts a
join ns.orders o
on a.id = o.account_id
group by 1,2
having o.total_amt_usd < 1000
order by 3 desc;

#Which account has spent the most with us?
select a.id, a.name, o.total_amt_usd
from ns.accounts a
join ns.orders o
on a.id = o.account_id
group by 1,2
order by 3 desc
limit 1;


#Which account has spent the least with us?
select a.id, a.name, o.total_amt_usd
from ns.accounts a
join ns.orders o
on a.id = o.account_id
group by 1,2
order by 3 
limit 1;

#Which accounts used facebook as a channel to contact customers more than 6 times?
select a.name, count(w.id) number_of_times
from ns.web_events w
inner join ns.accounts a
on w.account_id = a.id
where w.channel = 'facebook'
group by 1
having count(*) > 6
order by 2 desc ;


#Which account used facebook most as a channel?
select a.name, count(w.id) number_of_times
from ns.web_events w
inner join ns.accounts a
on w.account_id = a.id
where w.channel = 'facebook'
group by 1
order by 2 desc
limit 1 ;


#Which channel was most frequently used by most accounts?
select a.name, w.channel channel, count(w.id) most_used
from ns.web_events w
inner join ns.accounts a
on w.account_id = a.id
group by 1,2
order by 3 desc;
