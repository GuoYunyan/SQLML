# The guide to run SSB testset



## Step1: Generate and load data

Data source: https://github.com/eyalroz/ssb-dbgen

Follow the guide in this repository to generate dataset and load the data into the database.

Some helper files are : `./create_table.sql`, `./import_data.sql`. 

You need to mofidy path in the file.



## Step2: Expand table and build indexes

Use `./ssb-expand-index.sql` to build indexes in the database.



## Step3: Execute the queryset

Use our modified queryset in `./queries` to test the dataset.

A simple script `./ssb-test` is provided as an example. Possibly it needs to be modified to fit in other environments.



