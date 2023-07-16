# The guide to run TPC-H testset



## Step1: Generate and load data

Data source: https://github.com/gregrahn/tpch-kit

Follow the guide in this repository to generate dataset and load the data into the database.

SQL code to create tables is in `./tpch-create.sql`.

SQL code to copy data into the database may be like:

```sql
delete from NATION;
delete from REGION;
delete from PART;
delete from SUPPLIER;
delete from PARTSUPP;
delete from CUSTOMER;
delete from ORDERS;
delete from LINEITEM;

\copy NATION from '~/my-tpch/tpch-kit/dbgen/nation.tbl' DELIMITER '|';
\copy REGION from '~/my-tpch/tpch-kit/dbgen/region.tbl' DELIMITER '|';
\copy PART from '~/my-tpch/tpch-kit/dbgen/part.tbl' DELIMITER '|';
\copy SUPPLIER from '~/my-tpch/tpch-kit/dbgen/supplier.tbl' DELIMITER '|';
\copy PARTSUPP from '~/my-tpch/tpch-kit/dbgen/partsupp.tbl' DELIMITER '|';
\copy CUSTOMER from '~/my-tpch/tpch-kit/dbgen/customer.tbl' DELIMITER '|';
\copy ORDERS from '~/my-tpch/tpch-kit/dbgen/orders.tbl' DELIMITER '|';
\copy LINEITEM from '~/my-tpch/tpch-kit/dbgen/lineitem.tbl' DELIMITER '|';
```





## Step2: build indexes

Use `./tpch-index.sql` to build indexes in the database.



## Step3: Execute the queryset

Use our modified queryset in `./queries` to test the dataset.

A simple script `./tpch-test` is provided as an example. Possibly it needs to be modified to fit in other environments.



