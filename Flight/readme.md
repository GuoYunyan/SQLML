# The guide to run Flight testset



### Step0: Download data

There are 3 files in need, `airlines.csv` and `airports.csv` are provided in this document. `flights.csv` is big and needs to be processed.

You can download `flights.csv` from [This webste](https://www.kaggle.com/datasets/usdot/flight-delays) , move it to the same path as this file, and run `python3 wash_flights.py`. 

## Step1: Load data

Load three files into the database: `airlines.csv`, `airports.csv`, `flights.csv`



Table are created as belows:

```sql
CREATE TABLE airlines (
    iata_code CHAR(2) PRIMARY KEY,
    airline VARCHAR(255) NOT NULL
);

CREATE TABLE airports (
    iata_code CHAR(3) PRIMARY KEY,
    airport VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state CHAR(2) NOT NULL,
    country CHAR(3) NOT NULL,
    latitude NUMERIC(9, 5),
    longitude NUMERIC(9, 5)
);

CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    day_of_week INTEGER,
    airline CHAR(2),
    flight_number INTEGER,
    tail_number CHAR(6),
    origin_airport CHAR(3),
    destination_airport CHAR(3),
    scheduled_departure NUMERIC(10, 2),
    departure_time NUMERIC(10, 2),
    departure_delay INTEGER,
    taxi_out NUMERIC(10, 2),
    wheels_off INTEGER,
    scheduled_time NUMERIC(10, 2),
    elapsed_time INTEGER,
    air_time NUMERIC(10, 2),
    distance NUMERIC(10, 2),
    wheels_on INTEGER,
    taxi_in NUMERIC(10, 2),
    scheduled_arrival INTEGER,
    arrival_time INTEGER,
    arrival_delay INTEGER,
    diverted BOOLEAN,
    cancelled BOOLEAN,
    is_delayed BOOLEAN
);
```



```sql
COPY airlines (iata_code, airline)
FROM '/home/postgres/my-flight/airlines.csv'
WITH (FORMAT csv, HEADER);

COPY airports (iata_code, airport, city, state, country, latitude, longitude)
FROM '/home/postgres/my-flight/airports.csv'
WITH (FORMAT csv, HEADER);

COPY flights(year,month,day,day_of_week,airline,flight_number,tail_number,origin_airport,destination_airport,scheduled_departure,departure_time,departure_delay,taxi_out,wheels_off,scheduled_time,elapsed_time,air_time,distance,wheels_on,taxi_in,scheduled_arrival,arrival_time,arrival_delay,diverted,cancelled,is_delayed)
FROM '/home/postgres/my-flight/flights.csv'
WITH (FORMAT csv, HEADER);

-- remember to execute below
ALTER TABLE airlines ADD COLUMN airlineid INTEGER;

WITH airlines_with_row_number AS (
    SELECT iata_code, airline, ROW_NUMBER() OVER (ORDER BY iata_code) AS airlineid
    FROM airlines
)
UPDATE airlines
SET airlineid = airlines_with_row_number.airlineid
FROM airlines_with_row_number
WHERE airlines.iata_code = airlines_with_row_number.iata_code;

ALTER TABLE airlines 
ALTER COLUMN airlineid TYPE NUMERIC(8,2);
CREATE TABLE airports2 AS SELECT * FROM airports;
```



## Step2: Query execution

We provide one exemplary query as below, more templates can be found in `./flight_queries`

Notice the comments, in our design, these comments are used as hints for our demo, to tell our modified pg that `rowname.colname` is used as a feature. 

```sql
/*flights.distance flights.air_time airlines.airlineid airports.latitude airports2.longitude*/
EXPLAIN ANALYZE
SELECT *
FROM 
    flights,
    airlines,
    airports AS startap,
    airports2 AS destap
WHERE
    flights.airline = airlines.iata_code 
    AND flights.origin_airport = startap.iata_code
    AND flights.destination_airport = destap.iata_code
    AND -0.7278 + (-0.0034) * flights.distance + (0.0290) * flights.air_time + (0.0211) * airlines.airlineid + (-0.0035) * startap.latitude + 0.0035 * destap.longitude >= 0.0;
```

