select * 
from ns.web_events
where channel = 'facebook'

union all

select * 
from ns.web_events;
#Write a query that uses UNION ALL on two instances (and selecting all columns) of the accounts table. 
#Then inspect the results and answer the subsequent quiz.
select count(*) count
from
(select * 
from ns.accounts

union all

select * 
from ns.accounts) tab1;

#Add a WHERE clause to each of the tables that you unioned in the query above, filtering the first table where name equals 
#Walmart and filtering the second table where name equals Disney. Inspect the results then answer the subsequent quiz.

select *
from
(select * 
from ns.accounts
where name = 'Walmart'

union all

select * 
from ns.accounts
where name = 'Disney'
) tab1;


select *
from ns.accounts
where name = 'Disney' or name = 'Walmart';

#Perform the union in your first query (under the Appending Data via UNION header) in a common table 
#expression and name it double_accounts. Then do a COUNT the number of times a name appears in the double_accounts table.
# If you do this correctly, your query results should have a count of 2 for each name.

with tab1 as (
select *
from ns.accounts

union all

select * 
from ns.accounts 
)
select name, count(*) count
from tab1
group by 1
