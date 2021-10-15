#In the accounts table, there is a column holding the website for each company. 
#The last three digits specify what type of web address they are using. 
#A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist
# in the accounts table.

select right(a.website, 3) extensions, count(*) count
from ns.accounts a
group by 1;

#There is much debate about how much the name (or even the first letter of a company name) matters. 
#Use the accounts table to pull the first letter of each company name to see the distribution of company
#names that begin with each letter (or number).

select upper(left(name, 1)) first_name, count(*) count
from ns.accounts
group by 1
order by 2 desc;

#Use the accounts table and a CASE statement to create two groups: one group of company names that 
#start with a number and a second group of those company names that start with a letter. What proportion of 
#company names start with a letter?

SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 1 ELSE 0 END AS num, 
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 0 ELSE 1 END AS letter
      FROM ns.accounts) t1;


select 
case when left(name, 1)  REGEXP '[0-9]+' then 'number'
else 'alphabet' end as detection, count(*) count
from ns.accounts
group by 1;


#Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, 
#and what percent start with anything else?

select 
case when lower(left(name, 1)) in ('a','e','i','o','u') then 'vowels'
else 'consonant' end as alpha, count(*) number_of_counts
from ns.accounts
group by 1
