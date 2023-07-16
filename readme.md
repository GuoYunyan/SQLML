# Steps to install postgresql in a Linux machine

1. tar -xvzf postgresql_modified.tar.gz
2. cd postgresql_modified
3. ./configure --prefix=/opt/pgsql --enable-debug 
4. make world
5. make install-world
6. adduser postgres 
7. mkdir /opt/pgsql/data
8. chown -R postgres:postgres /opt/pgsql/data
9. su - postgres
10. /opt/pgsql/bin/initdb -D /opt/pgsql/data
11. /opt/pgsql/bin/pg_ctl -D /opt/pgsql/data -l logfile start
12. /opt/pgsql/bin/createdb genericdb
13. /opt/pgsql/bin/psql genericdb



# What are changed

Three pairs of files are added, and some more are modified for implementation.

1. Logical optimization:
    - `backend/optimizer/plan/mlinfo.c` 
    - `include/optimizer/mlinfo.h`
2. InferOP definition and application: 
    - `backend/optimizer/plan/inferops.c` 
    - `include/optimizer/inferops.h`
3. Cost-optimization for progressive inference
    - `backend/optimizer/plan/dynamic.c`
    - `include/optimizer/dynamic.h`
4. postgresql configureation
    - `data/postgresql.conf`
    - Configuration variables are added:
        - `enable_logicml` : whether to use logical optimization
        - `enable_physicml` : whether to use physical optimization
            - If `enable_physical = on`, one of the choices below must be turned on
            - `physicml_pushdown`: use basic progressive inference
            - `physicml_dynamic` : use cost-optimized algorithm
5. a boolean value `using_bilateral`



# Configuration usage

- When testing logical optimization, use: `enable_logicml = on`
- When testing physical optimization, use: `enable_physicml = on`
    - For progressive inference method, use: `physicml_pushdown = on`
    - For cost-optimized method, use: `physicml_dynamic = on`
- Notice:
    - `enable_logicml` and `enable_physicml` are independent, you can turn on one of them, or both, or none(then nothing is changed).
    - When `enable_physicml = on`, one of `physicml_pushdown` / `physicml_dynamic` must be turned on.



# How to use system table to inject information

We added a system table named `pg_inference`, like:

| tablename | columnname | minvalue | maxvalue |
| --------- | ---------- | -------- | -------- |
| MyTable   | MyColumn   | 0.0      | 10.0     |

Before using progressive inference, you need to insert values of relevant features.

```sql
INSERT INTO pg_inference VALUES('MyTable', 'MyColumn', 0.0, 10.0);
```

When using progressive inference, you need to add a line of comment before SQL, to indicate which features you are using(its minvalue and max value will be used to make the inference):

```sql
/* MyTable1.MyColumn1 MyTable2.MyColumn2 MyTable3.MyColumn3*/
SELECT * FROM
	MyTable1, MyTable2, MyTable3
WHERE
	MyTable1.pkey = MyTable2.fkey AND
	MyTable1.pkey = MyTable3.fkey AND
	10 * MyTable1.MyColumn1 + 20 * MyTable2.MyColumn2 + 30 * MyTable3.MyColumn3 < 40
```

