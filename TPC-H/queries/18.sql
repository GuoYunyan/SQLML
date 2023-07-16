EXPLAIN ANALYZE
select
    c_name,
    c_custkey,
    o_orderkey,
    o_orderdate,
    o_totalprice,
    sum(l_quantity)
from
    lineitem AS li,
    part AS p,
    partsupp AS ps,
    orders AS o,
    customer AS c,
    supplier AS s
where
    o_orderkey in (
        select
            l_orderkey
        from
            lineitem
        group by
            l_orderkey having
                sum(l_quantity) > 300
    )
    and c_custkey = o_custkey
    and o_orderkey = l_orderkey 

    AND li.L_PARTKEY = ps.PS_PARTKEY
    AND li.L_SUPPKEY = ps.PS_SUPPKEY
    AND p.P_PARTKEY = ps.PS_PARTKEY
    AND ps.PS_SUPPKEY = s.S_SUPPKEY
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05
group by
    c_name,
    c_custkey,
    o_orderkey,
    o_orderdate,
    o_totalprice
order by
    o_totalprice desc,
    o_orderdate
    limit 100;
