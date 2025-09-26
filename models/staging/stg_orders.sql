with orders as (
  select * from {{ source('tpch', 'orders') }}
),
customers as (
  select * from {{ source('tpch', 'customer') }}
)
select
  o.o_orderkey         as order_key,
  o.o_custkey          as cust_key,
  c.c_name             as customer_name,
  o.o_totalprice       as total_price,
  o.o_orderdate        as order_date,
  extract(year from o.o_orderdate) as order_year,
  o.o_orderstatus      as order_status,
  o.o_orderpriority    as order_priority,
  o.o_clerk            as clerk,
  o.o_shippriority     as ship_priority,
  o.o_comment          as comment
from orders o
join customers c
  on o.o_custkey = c.c_custkey

