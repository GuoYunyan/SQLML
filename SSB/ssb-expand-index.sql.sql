CREATE INDEX customer_pkey ON customer (c_custkey);
CREATE INDEX date_pkey ON date (d_datekey);
CREATE INDEX lineorder_pkey ON lineorder (lo_orderkey, lo_linenumber);
CREATE INDEX lineorder_custkey_idx ON lineorder (lo_custkey);
CREATE INDEX lineorder_partkey_idx ON lineorder (lo_partkey);
CREATE INDEX lineorder_suppkey_idx ON lineorder (lo_suppkey);
CREATE INDEX lineorder_orderdate_idx ON lineorder (lo_orderdate);
CREATE INDEX supplier_pkey ON supplier (s_suppkey);
CREATE INDEX part_pkey ON part (p_partkey);

ALTER TABLE lineorder ADD COLUMN lo_isgood BOOLEAN;

UPDATE lineorder
SET lo_isgood = (random() >= 0.5);

ALTER TABLE customer ADD COLUMN c_age NUMERIC(10, 2);
WITH lineorder_customer AS (
  SELECT lo.lo_custkey, lo.lo_isgood
  FROM lineorder lo
)
UPDATE customer
SET c_age = CASE
  WHEN lineorder_customer.lo_isgood THEN 30 + floor(random() * 10 + 10)
  ELSE 30 - floor(random() * 10 + 10)
END
FROM lineorder_customer
WHERE customer.c_custkey = lineorder_customer.lo_custkey;

UPDATE customer
SET c_age = floor(random() * 30 + 15)
WHERE c_age = 0.00;

ALTER TABLE supplier ADD COLUMN s_scale NUMERIC(10, 2);

WITH lineorder_supplier AS (
  SELECT lo.lo_suppkey, lo.lo_isgood
  FROM lineorder lo
)
UPDATE supplier
SET s_scale = CASE
  WHEN lineorder_supplier.lo_isgood THEN 500 + floor(random() * 500)
  ELSE 300 - floor(random() * 200)
END
FROM lineorder_supplier
WHERE supplier.s_suppkey = lineorder_supplier.lo_suppkey;

UPDATE customer
SET c_age = floor(random() * 30 + 15)
WHERE c_age = 0.00;

ALTER TABLE date ADD COLUMN d_luck NUMERIC(10, 2);

WITH lineorder_date AS (
  SELECT lo.lo_orderdate, lo.lo_isgood
  FROM lineorder lo
)
UPDATE date
SET d_luck = CASE
  WHEN lineorder_date.lo_isgood THEN 100 + random() * 50
  ELSE 100 - random() * 50
END
FROM lineorder_date
WHERE date.d_datekey = lineorder_date.lo_orderdate;

UPDATE date
SET d_luck = 75 + random() * 50
WHERE d_luck IS NULL;

ALTER TABLE part ADD COLUMN p_percent NUMERIC(10, 2);

WITH lineorder_part AS (
  SELECT lo.lo_partkey, lo.lo_isgood
  FROM lineorder lo
)
UPDATE part
SET p_percent = CASE
  WHEN lineorder_part.lo_isgood THEN 30 + 70 * random()
  ELSE 70 - 50 * random()
END
FROM lineorder_part
WHERE part.p_partkey = lineorder_part.lo_partkey;

CREATE INDEX supplier_scale_idx ON supplier(s_scale);
CREATE INDEX part_percent_idx ON part(p_percent);
CREATE INDEX customer_age_idx ON customer(c_age);