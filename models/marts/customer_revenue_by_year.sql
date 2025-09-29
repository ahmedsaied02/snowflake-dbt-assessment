with stg_orders as (
    select *
    from {{ ref('stg_orders') }}
),

base as (
    select
        o.order_key,
        o.cust_key,
        o.order_year,
        l.l_extendedprice * (1 - l.l_discount) as line_revenue
    from stg_orders o
    join {{ source('tpch', 'lineitem') }} l
      on o.order_key = l.l_orderkey
)

select
    b.cust_key,
    b.order_year,
    sum(b.line_revenue) as total_revenue
from base b
group by b.cust_key, b.order_year
