EXPLAIN ANALYZE
select
    c_count,
    count(*) as custdist
from
    (
        select
            c_custkey,
            count(o_orderkey)
        from
            customer AS c left outer join orders AS o on
                c_custkey = o_custkey and o_comment not like '%special%requests%',
            lineitem AS li,
            part AS p,
            partsupp AS ps,
            supplier AS s
        WHERE
            li.L_ORDERKEY = o.O_ORDERKEY
            AND o.O_CUSTKEY = c.C_CUSTKEY
            AND li.L_PARTKEY = ps.PS_PARTKEY
            AND li.L_SUPPKEY = ps.PS_SUPPKEY
            AND p.P_PARTKEY = ps.PS_PARTKEY
            AND ps.PS_SUPPKEY = s.S_SUPPKEY
            AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
            AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05
        group by
            c_custkey
    ) as c_orders (c_custkey, c_count)
group by
    c_count
order by
    custdist desc,
    c_count desc;
