EXPLAIN ANALYZE
SELECT
  l_returnflag,
  l_linestatus,
  SUM(l_quantity) AS sum_qty,
  SUM(l_extendedprice) AS sum_base_price,
  SUM(l_extendedprice * (1 - l_discount)) AS sum_disc_price,
  SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge,
  AVG(l_quantity) AS avg_qty,
  AVG(l_extendedprice) AS avg_price,
  AVG(l_discount) AS avg_disc,
  COUNT(*) AS count_order
FROM
  lineitem AS li,
  part AS p,
  partsupp AS ps,
  orders AS o,
  customer AS c,
  supplier AS s
WHERE
  l_shipdate <= DATE '1998-12-01' - INTERVAL '90' DAY 
  AND li.L_ORDERKEY = o.O_ORDERKEY
  AND o.O_CUSTKEY = c.C_CUSTKEY
  AND li.L_PARTKEY = ps.PS_PARTKEY
  AND li.L_SUPPKEY = ps.PS_SUPPKEY
  AND p.P_PARTKEY = ps.PS_PARTKEY
  AND ps.PS_SUPPKEY = s.S_SUPPKEY
  AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL >= 175193.48
  AND 149751.77519 + 36047.47266 * li.L_TAX + 25.20963 * p.P_RETAILPRICE + 0.12624 * ps.PS_SUPPLYCOST + (-0.00388) * c.C_ACCTBAL + (-0.00218) * s.S_ACCTBAL <= 175953.05
GROUP BY
  l_returnflag,
  l_linestatus
ORDER BY
  l_returnflag,
  l_linestatus;