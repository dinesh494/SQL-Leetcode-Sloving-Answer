-- Write your MySQL query statement below
with cte as(
    Select *, distance_km/fuel_consumed as fuel_efficency
    from trips
),
cte2 as(
    select c.driver_id,d.driver_name, 
        avg(case
            when month(trip_date) between 1 and 6 then fuel_efficency 
            else null
        end) as first_half_avg,
        avg(case
            when month(trip_date) between 7 and 12 then fuel_efficency 
            else null
        end) as second_half_avg
    from cte as c
    left join drivers as d
    on c.driver_id = d.driver_id
    group by c.driver_id, d.driver_name
)
select driver_id, driver_name, round(first_half_avg,2) as first_half_avg, round(second_half_avg,2)as second_half_avg,round((second_half_avg-first_half_avg),2)as  efficiency_improvement
from cte2
where second_half_avg>first_half_avg
order by efficiency_improvement desc, driver_name;
