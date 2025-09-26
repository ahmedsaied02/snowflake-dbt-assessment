with orders as (
  select o_orderkey, o_custkey
  from {{ source('tpch', 'orders') }}
),
lineitem as (
  select l_orderkey, l_extendedprice, l_discount
  from {{ source('tpch', 'lineitem') }}
),
customer as (
  select c_custkey, c_name
  from {{ source('tpch', 'customer') }}
),
revenue_per_order as (
  select
    o.o_custkey as cust_key,
    sum(l.l_extendedprice * (1 - l.l_discount)) as order_revenue
  from orders o
  join lineitem l on l.l_orderkey = o.o_orderkey
  group by 1
)
select
  c.c_custkey      as cust_key,
  c.c_name         as customer_name,
  sum(r.order_revenue) as total_revenue
from revenue_per_order r
join customer c on c.c_custkey = r.cust_key
group by 1,2
