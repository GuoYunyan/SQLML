EXPLAIN ANALYZE
SELECT SUM(LO_REVENUE), (LO_ORDERDATE / 10000) AS YEAR, P_BRAND1
FROM 
    LINEORDER AS lo,
    DATE AS d,
    SUPPLIER AS s,
    PART AS p,
    CUSTOMER AS c
WHERE 
    P_BRAND1 = 'MFGR#2239' 
    AND S_REGION = 'EUROPE'
    AND LO_ORDERDATE = D_DATEKEY
    AND LO_SUPPKEY = S_SUPPKEY
    AND LO_PARTKEY = P_PARTKEY
    AND LO_CUSTKEY = C_CUSTKEY
    AND (-1399.598 + 3.687 * c.c_age + 1.844 * d.d_luck + 7.377 * p.p_percent + 3.687 * s.s_scale) >= 0.0
GROUP BY YEAR, P_BRAND1
ORDER BY YEAR, P_BRAND1;