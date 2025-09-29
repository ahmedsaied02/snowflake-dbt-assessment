with stg_orders as (
    select *
    from {{ ref('stg_orders') }}
),

lineitem as (
    select 
        l_orderkey, 
        l_extendedprice, 
        l_discount
    from {{ source('tpch', 'lineitem') }}
),

revenue_per_order as (
    select
        o.cust_key,
        sum(l.l_extendedprice * (1 - l.l_discount)) as total_revenue
    from stg_orders o
    join lineitem l on l.l_orderkey = o.order_key
    group by o.cust_key
),

customers as (
    select distinct cust_key, customer_name
    from stg_orders
)

select
    c.cust_key,
    c.customer_name,
    r.total_revenue
from revenue_per_order r
join customers c on c.cust_key = r.cust_key
