--find the "seat_no" of 3 or more consecutive empty seats.

create table bms (seat_no int ,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');


--select * from bms


with cte as (
select *, 
lead(is_empty, 1) over(order by seat_no) as one_lead, 
lead(is_empty, 2) over(order by seat_no) as two_lead, 
lag(is_empty, 1) over(order by seat_no) as one_lag, 
lag(is_empty, 2) over(order by seat_no) as two_lag
from bms)

select seat_no
from cte
where (is_empty = 'Y' and one_lead = 'Y' and two_lead = 'Y') or (one_lag = 'Y' and is_empty = 'Y' and one_lead = 'Y') or (two_lag = 'Y' and one_lag = 'Y' and is_empty = 'Y')