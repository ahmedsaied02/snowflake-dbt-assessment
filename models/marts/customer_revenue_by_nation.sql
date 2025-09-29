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

nation as (
    select 
        n_nationkey, 
        n_name as nation_name
    from {{ source('tpch', 'nation') }}
),

-- ✅ Deduplicate customers
customers as (
    select distinct
        cust_key,
        customer_name,
        nation_key
    from stg_orders
),

revenue_per_order as (
    select
        o.cust_key,
        sum(l.l_extendedprice * (1 - l.l_discount)) as order_revenue
    from stg_orders o
    join lineitem l 
      on l.l_orderkey = o.order_key
    group by 1
)

select
    c.cust_key,
    c.customer_name,
    n.nation_name,
    r.order_revenue
from revenue_per_order r
join customers c 
  on c.cust_key = r.cust_key
join nation n 
  on c.nation_key = n.n_nationkey
