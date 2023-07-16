EXPLAIN ANALYZE
select
    n_name,
    sum(l_extendedprice * (1 - l_discount)) as revenue
from
    customer AS c,
    orders AS o,
    lineitem AS li,
    supplier AS s,
    nation,
    region,
    part AS p,
    partsupp AS ps
where
    c_custkey = o_custkey
    and l_orderkey = o_orderkey
    and l_suppkey = s_suppkey
    AND li.L_PARTKEY = ps.PS_PARTKEY
    AND li.L_SUPPKEY = ps.PS_SUPPKEY
    AND p.P_PARTKEY = ps.PS_PARTKEY

    and c_nationkey = s_nationkey
    and s_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and r_name = 'ASIA'
    and o_orderdate >= date '1994-01-01'
    and o_orderdate < date '1994-01-01' + interval '1' year 
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05

group by
    n_name
order by
    revenue desc;
