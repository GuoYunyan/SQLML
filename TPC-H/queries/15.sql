EXPLAIN ANALYZE
with revenue (supplier_no, total_revenue) as --change view to cte
(
    select
        l_suppkey,
        sum(l_extendedprice * (1 - l_discount))
    from
        lineitem
    where
        l_shipdate >= date '1996-01-01'
        and l_shipdate < date '1996-01-01' + interval '3 month'
    group by
        l_suppkey
)
select
    s_suppkey,
    s_name,
    s_address,
    s_phone,
    total_revenue
from
    lineitem AS li,
    part AS p,
    partsupp AS ps,
    orders AS o,
    customer AS c,
    supplier AS s,
    revenue
where
    s_suppkey = supplier_no
    and total_revenue = (
        select
            max(total_revenue)
        from
            revenue
    )
    AND li.L_ORDERKEY = o.O_ORDERKEY
    AND o.O_CUSTKEY = c.C_CUSTKEY
    AND li.L_PARTKEY = ps.PS_PARTKEY
    AND li.L_SUPPKEY = ps.PS_SUPPKEY
    AND p.P_PARTKEY = ps.PS_PARTKEY
    AND ps.PS_SUPPKEY = s.S_SUPPKEY
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05
order by
    s_suppkey;
