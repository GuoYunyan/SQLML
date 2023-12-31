EXPLAIN ANALYZE
SELECT SUM(LO_EXTENDEDPRICE * LO_DISCOUNT) AS REVENUE
FROM  
    DATE AS d CROSS JOIN
    LINEORDER AS lo CROSS JOIN
    PART AS p CROSS JOIN
    SUPPLIER AS s CROSS JOIN
    CUSTOMER AS c
WHERE  
    LO_ORDERDATE = D_DATEKEY
    AND D_WEEKNUMINYEAR = 6
    AND D_YEAR = 1994
    AND LO_DISCOUNT BETWEEN  5 AND 7
    AND LO_QUANTITY BETWEEN  26 AND 35
    AND LO_SUPPKEY = S_SUPPKEY
    AND LO_PARTKEY = P_PARTKEY
    AND LO_CUSTKEY = C_CUSTKEY
    AND (-1399.598 + 3.687 * c.c_age + 1.844 * d.d_luck + 7.377 * p.p_percent + 3.687 * s.s_scale) >= 0.0;