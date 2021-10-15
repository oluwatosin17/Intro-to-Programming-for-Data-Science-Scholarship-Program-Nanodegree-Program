#Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.
select primary_poc,
left(primary_poc, position(' ' in primary_poc)) firstname , 
right(primary_poc, (length(primary_poc)- position(' ' in primary_poc))) lastname
from ns.accounts a;


#Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.
select name,
left(name, position(' ' in name)) firstname , 
right(name, (length(name)- position(' ' in name))) lastname
from ns.sales_rep;

select lower(right(right(primary_poc, (length(primary_poc)- position(' ' in primary_poc))),1))
from
ns.accounts