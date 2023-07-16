/*flights.distance flights.air_time airlines.airlineid airports.latitude airports2.longitude*/
EXPLAIN ANALYZE
SELECT airline, AVG_distance
FROM (
    SELECT al.airline, AVG(flights.distance) AS AVG_distance
    FROM
        flights,
        airlines AS al,
        airports AS startap,
        airports2 AS destap
    WHERE
        flights.airline = al.iata_code 
        AND flights.origin_airport = startap.iata_code
        AND flights.destination_airport = destap.iata_code
        AND -0.7278 + (-0.0034) * flights.distance + (0.0290) * flights.air_time + (0.0211) * al.airlineid + (-0.0035) * startap.latitude + 0.0035 * destap.longitude >= 0.0
    GROUP BY al.airline
) AS subquery
ORDER BY AVG_distance DESC;
