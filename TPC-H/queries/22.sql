EXPLAIN ANALYZE
select
    cntrycode,
    count(*) as numcust,
    sum(c_acctbal) as totacctbal
from
    (
        select
            substring(c_phone from 1 for 2) as cntrycode,
            c_acctbal
        from
            lineitem AS li,
            part AS p,
            partsupp AS ps,
            orders AS o,
            customer AS c,
            supplier AS s
        where
            substring(c_phone from 1 for 2) in
                ('13', '31', '23', '29', '30', '18', '17')
            and c_acctbal > (
                select
                    avg(c_acctbal)
                from
                    customer
                where
                    c_acctbal > 0.00
                    and substring(c_phone from 1 for 2) in
                        ('13', '31', '23', '29', '30', '18', '17')
            )
            and not exists (
                select
                    *
                from
                    orders
                where
                    o_custkey = c_custkey
            )
            AND li.L_ORDERKEY = o.O_ORDERKEY
            AND o.O_CUSTKEY = c.C_CUSTKEY
            AND li.L_PARTKEY = ps.PS_PARTKEY
            AND li.L_SUPPKEY = ps.PS_SUPPKEY
            AND p.P_PARTKEY = ps.PS_PARTKEY
            AND ps.PS_SUPPKEY = s.S_SUPPKEY
            AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
            AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05
    ) as custsale
group by
    cntrycode
order by
    cntrycode;
