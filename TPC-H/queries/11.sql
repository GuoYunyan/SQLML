EXPLAIN ANALYZE
select
    ps_partkey,
    sum(ps_supplycost * ps_availqty) as value
from
    partsupp AS ps,
    supplier AS s,
    nation,
    lineitem AS li,
    part AS p,
    orders AS o,
    customer AS c
where
    ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'GERMANY'
    
    AND li.L_ORDERKEY = o.O_ORDERKEY
    AND o.O_CUSTKEY = c.C_CUSTKEY
    AND li.L_PARTKEY = ps.PS_PARTKEY
    AND li.L_SUPPKEY = ps.PS_SUPPKEY
    AND p.P_PARTKEY = ps.PS_PARTKEY
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05
group by
    ps_partkey having
        sum(ps_supplycost * ps_availqty) > (
            select
                sum(ps_supplycost * ps_availqty) * 0.0000001000
            from
                partsupp,
                supplier,
                nation
            where
                ps_suppkey = s_suppkey
                and s_nationkey = n_nationkey
                and n_name = 'GERMANY'
        )
order by
    value desc;
