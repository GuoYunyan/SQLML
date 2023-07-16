\copy supplier from '/home/postgres/my-ssb/ssb-dbgen/supplier.tbl' DELIMITER '|';

\copy part from '/home/postgres/my-ssb/ssb-dbgen/part.tbl' DELIMITER '|';

\copy customer from '/home/postgres/my-ssb/ssb-dbgen/customer.tbl' DELIMITER '|';

\copy date from '/home/postgres/my-ssb/ssb-dbgen/date.tbl' DELIMITER '|';

\copy lineorder from '/home/postgres/my-ssb/ssb-dbgen/lineorder.tbl' DELIMITER '|';