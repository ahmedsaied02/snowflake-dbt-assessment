with base as (
    select
        o.o_orderkey,
        o.o_custkey,
        extract(year from o.o_orderdate) as order_year,
        l.l_extendedprice * (1 - l.l_discount) as line_revenue
    from {{ source('tpch', 'orders') }} o
    join {{ source('tpch', 'lineitem') }} l
      on o.o_orderkey = l.l_orderkey
)
select
    b.o_custkey as cust_key,
    b.order_year,
    sum(b.line_revenue) as total_revenue
from base b
group by b.o_custkey, b.order_year
