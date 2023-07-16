EXPLAIN ANALYZE
select
    s_name,
    s_address
from
    supplier AS s,
    (
        select
            myps.ps_suppkey AS tempvalue
        from
            partsupp AS myps
            JOIN (
                select
                    mypart.p_partkey as partkey
                from
                    part AS mypart
                where
                    mypart.p_name like 'forest%'
            ) AS mypkey ON mypkey.partkey = myps.ps_partkey
        where ps_availqty > (
                select
                    0.5 * sum(l_quantity)
                from
                    lineitem
                where
                    l_partkey = ps_partkey
                    and l_suppkey = ps_suppkey
                    and l_shipdate >= date '1994-01-01'
                    and l_shipdate < date '1994-01-01' + interval '1' year
            )
    ) AS temp,
    lineitem AS li,
    nation,
    part AS p,
    partsupp AS ps,
    orders AS o,
    customer AS c
where
    temp.tempvalue = s.s_suppkey

    and s_nationkey = n_nationkey
    and n_name = 'CANADA'
    AND li.L_ORDERKEY = o.O_ORDERKEY
    AND o.O_CUSTKEY = c.C_CUSTKEY
    AND li.L_PARTKEY = ps.PS_PARTKEY
    AND li.L_SUPPKEY = ps.PS_SUPPKEY
    AND p.P_PARTKEY = ps.PS_PARTKEY
    AND ps.PS_SUPPKEY = s.S_SUPPKEY
  AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
  AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05
order by
    s_name;
