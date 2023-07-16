/*flights.distance flights.air_time airlines.airlineid airports.latitude airports2.longitude*/
EXPLAIN ANALYZE
SELECT 
    startap.airport, 
    flights.year, 
    flights.month, 
    flights.day, 
    AVG(flights.departure_delay) AS avg_departure_delay
FROM 
    flights,
    airlines,
    airports AS startap,
    airports2 AS destap
WHERE
    flights.airline = airlines.iata_code 
    AND flights.origin_airport = startap.iata_code
    AND flights.destination_airport = destap.iata_code
    AND -0.7278 + (-0.0034) * flights.distance + (0.0290) * flights.air_time + (0.0211) * airlines.airlineid + (-0.0035) * startap.latitude + 0.0035 * destap.longitude >= 0.0
GROUP BY 
    startap.airport, 
    flights.year, 
    flights.month, 
    flights.day
ORDER BY 
    startap.airport, 
    flights.year, 
    flights.month, 
    flights.day;
