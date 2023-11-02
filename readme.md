

# Smart

Smart is an open-source project for optimizing SQL+ML ARchiTecture within database optimizers.



## Compilation and Installation

Smart is developed from PostgreSQL 14, enhancing it with machine learning capabilities for query optimization. To compile and install Smart on a Linux server machine, execute the following commands:

```bash
# Extract the Smart source code
tar -xvzf smart-pg-core.tar.gz
cd smart-pg-core

# Configure the installation with debugging enabled and specify the installation directory
./configure --prefix=/opt/pgsql --enable-debug 

# Compile the source code using 4 parallel jobs and install the compiled binaries
make -j 4 && make install

# Add the PostgreSQL user and create a directory for the database data
adduser postgres 
mkdir /opt/pgsql/data
chown -R postgres:postgres /opt/pgsql/data

# Initialize the database cluster and start the database server
su - postgres -c "/opt/pgsql/bin/initdb -D /opt/pgsql/data"
su - postgres -c "/opt/pgsql/bin/pg_ctl -D /opt/pgsql/data -l logfile start"
```



## Configuration

Smart introduces several configuration options to fine-tune its behavior. After installation, you can adjust these settings in the `postgresql.conf` file located in the data directory. Here are some key configuration variables:

- `enable_logicml`: Enable or disable logical optimization for atomic predicates.
- `enable_physicml`: Enable or disable physical optimization for composite predicates.
  - `physicml_pushdown`: Pushdown composite predicates and deploying progressive inference.
  - `physicml_dynamic`: Optimize positions of composite predicates using cost-optimal inference.

Please note that when `enable_physicml` is set to `on`, either `physicml_pushdown` or `physicml_dynamic` must also be turned on.





## System Table Utility

Smart introduces a system table named `pg_inference`. This table is structured as follows:

| tablename | columnname | minvalue | maxvalue |
| --------- | ---------- | -------- | -------- |
| MyTable   | MyColumn   | 0.0      | 10.0     |

### Populating the `pg_inference` Table

Before leveraging Smart, it's necessary to populate the `pg_inference` table with the relevant features and their min and max values.

```sql
INSERT INTO pg_inference VALUES('MyTable', 'MyColumn', 0.0, 10.0);
```

Including a comment line to indicate which features/columns are in the SQL statement, Smart will employ the min and max values from the `pg_inference` table:

```sql
/* MyTable1.MyColumn1 MyTable2.MyColumn2 MyTable3.MyColumn3*/
SELECT * FROM
    MyTable1, MyTable2, MyTable3
WHERE
    MyTable1.pkey = MyTable2.fkey AND
    MyTable1.pkey = MyTable3.fkey AND
    10 * MyTable1.MyColumn1 + 20 * MyTable2.MyColumn2 + 30 * MyTable3.MyColumn3 < 40
```

