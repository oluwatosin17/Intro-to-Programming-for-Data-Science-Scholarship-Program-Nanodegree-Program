#Use DISTINCT to test if there are any accounts associated with more than one region.
select distinct a.name, count(r.id) region_count
from ns.accounts a
inner join ns.sales_rep s
on a.sales_rep_id = s.id
inner join ns.region r
on s.region_id = r.id
group by 1
order by 2 desc;



#Have any sales reps worked on more than one account?
select s.id, s.name, count(*)
from ns.accounts a
inner join ns.sales_rep s
on a.sales_rep_id = s.id
group by 1,2
having count(*) > 1
order by 3 desc;