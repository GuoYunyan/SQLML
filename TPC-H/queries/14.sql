EXPLAIN ANALYZE
select
    100.00 * sum(case
        when p_type like 'PROMO%'
            then l_extendedprice * (1 - l_discount)
        else 0
    end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
from
    lineitem AS li,
    part AS p,
    partsupp AS ps,
    orders AS o,
    customer AS c,
    supplier AS s
where
    l_partkey = p_partkey
    and l_shipdate >= date '1995-09-01'
    and l_shipdate < date '1995-09-01' + interval '1' month
    
    AND li.L_ORDERKEY = o.O_ORDERKEY
    AND o.O_CUSTKEY = c.C_CUSTKEY
    AND li.L_PARTKEY = ps.PS_PARTKEY
    AND li.L_SUPPKEY = ps.PS_SUPPKEY
    AND ps.PS_SUPPKEY = s.S_SUPPKEY
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
    AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05;
