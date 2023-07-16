EXPLAIN ANALYZE
select
    s_name,
    count(*) as numwait
from
    lineitem l1,
    nation,
    part AS p,
    partsupp AS ps,
    orders AS o,
    customer AS c,
    supplier AS s
where
    s_suppkey = l1.l_suppkey
    and o_orderkey = l1.l_orderkey
    and o_orderstatus = 'F'
    and l1.l_receiptdate > l1.l_commitdate
    and exists (
        select
            *
        from
            lineitem l2
        where
            l2.l_orderkey = l1.l_orderkey
            and l2.l_suppkey <> l1.l_suppkey
    )
    and not exists (
        select
            *
        from
            lineitem l3
        where
            l3.l_orderkey = l1.l_orderkey
            and l3.l_suppkey <> l1.l_suppkey
            and l3.l_receiptdate > l3.l_commitdate
    )
    and s_nationkey = n_nationkey
    and n_name = 'SAUDI ARABIA'

    AND o.O_CUSTKEY = c.C_CUSTKEY
    AND l1.L_PARTKEY = ps.PS_PARTKEY
    AND l1.L_SUPPKEY = ps.PS_SUPPKEY
    AND p.P_PARTKEY = ps.PS_PARTKEY
  AND 149751.77519 + 36047.47266 * l1.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
  AND 149751.77519 + 36047.47266 * l1.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05
group by
    s_name
order by
    numwait desc,
    s_name
    limit 100;
