CREATE DATABASE IF NOT EXISTS ZIPRIDE_ANALYTICS_DB;

USE ZIPRIDE_ANALYTICS_DB;

CREATE TABLE DRIVERS (
    driver_id INT PRIMARY KEY,
    join_date DATE,
    vehicle_type VARCHAR(20),
    online_hours DECIMAL(8,2),
    rating DECIMAL(3,2)
);

CREATE TABLE RIDES (
    ride_id INT PRIMARY KEY,
    request_time DATETIME,
    pickup_area VARCHAR(100),
    drop_area VARCHAR(100),
    vehicle_type VARCHAR(20),
    ride_status VARCHAR(30)
);

CREATE TABLE TRIPS (
    ride_id INT PRIMARY KEY,
    driver_id INT,
    accept_time DATETIME,
    pickup_time DATETIME,
    trip_distance_km DECIMAL(8,2),
    trip_duration_min DECIMAL(8,2),
    fare DECIMAL(10,2),
    FOREIGN KEY (ride_id) REFERENCES RIDES(ride_id),
    FOREIGN KEY (driver_id) REFERENCES DRIVERS(driver_id)
);

CREATE TABLE PRICING (
    ride_id INT PRIMARY KEY,
    surge_multiplier DECIMAL(4,2),
    base_fare DECIMAL(10,2),
    discount DECIMAL(10,2),
    FOREIGN KEY (ride_id) REFERENCES RIDES(ride_id)
);

CREATE TABLE CANCELLATIONS (
    ride_id INT PRIMARY KEY,
    cancelled_by VARCHAR(30),
    cancel_reason VARCHAR(200),
    FOREIGN KEY (ride_id) REFERENCES RIDES(ride_id)
);
SHOW TABLES;

SET SESSION cte_max_recursion_depth = 10000;

INSERT INTO DRIVERS
(driver_id, join_date, vehicle_type, online_hours, rating)

WITH RECURSIVE driver_numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM driver_numbers
    WHERE n < 6000
)

SELECT
    10000 + n,

    DATE_ADD(
        '2023-01-01',
        INTERVAL FLOOR(RAND() * 1200) DAY
    ),

    CASE MOD(n - 1, 3)
        WHEN 0 THEN 'Bike'
        WHEN 1 THEN 'Auto'
        ELSE 'Cab'
    END,

    ROUND(80 + RAND() * 140, 2),

    ROUND(3 + RAND() * 2, 2)

FROM driver_numbers;

INSERT INTO RIDES
(ride_id, request_time, pickup_area, drop_area,
 vehicle_type, ride_status)

WITH RECURSIVE ride_numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM ride_numbers
    WHERE n < 10000
)

SELECT
    n,

    request_time,

    ELT(pickup_no,
        'Madhapur',
        'Gachibowli',
        'Hitech City',
        'Kukatpally',
        'Miyapur',
        'Ameerpet',
        'Banjara Hills',
        'Jubilee Hills',
        'Secunderabad',
        'Kondapur'
    ),

    ELT(
        MOD(pickup_no + drop_no - 1, 10) + 1,
        'Madhapur',
        'Gachibowli',
        'Hitech City',
        'Kukatpally',
        'Miyapur',
        'Ameerpet',
        'Banjara Hills',
        'Jubilee Hills',
        'Secunderabad',
        'Kondapur'
    ),

    vehicle_type,

    CASE
        WHEN HOUR(request_time) IN (8,9,10,17,18,19,20)
             AND status_random < 0.75
        THEN 'Completed'

        WHEN HOUR(request_time) IN (8,9,10,17,18,19,20)
        THEN 'Cancelled'

        WHEN status_random < 0.88
        THEN 'Completed'

        ELSE 'Cancelled'
    END

FROM (
    SELECT
        n,

        DATE_ADD(
            '2026-07-01 00:00:00',
            INTERVAL FLOOR(RAND() * 90 * 1440) MINUTE
        ) AS request_time,

        FLOOR(1 + RAND() * 10) AS pickup_no,
        FLOOR(1 + RAND() * 9) AS drop_no,

        ELT(
            FLOOR(1 + RAND() * 3),
            'Bike', 'Auto', 'Cab'
        ) AS vehicle_type,

        RAND() AS status_random

    FROM ride_numbers
) AS generated_rides;

INSERT INTO PRICING
(ride_id, surge_multiplier, base_fare, discount)

SELECT
    ride_id,

    CASE
        WHEN HOUR(request_time) IN (8,9,10,17,18,19,20)
        THEN ELT(FLOOR(1 + RAND() * 4), 1.2, 1.5, 2.0, 2.5)
        ELSE ELT(FLOOR(1 + RAND() * 4), 1.0, 1.0, 1.1, 1.2)
    END,

    CASE vehicle_type
        WHEN 'Bike' THEN 30
        WHEN 'Auto' THEN 50
        WHEN 'Cab' THEN 80
    END,

    ELT(FLOOR(1 + RAND() * 5), 0, 0, 10, 20, 30)

FROM RIDES;

INSERT INTO TRIPS
(ride_id, driver_id, accept_time, pickup_time,
 trip_distance_km, trip_duration_min, fare)

SELECT
    ride_id,
    driver_id,
    accept_time,

    DATE_ADD(
        accept_time,
        INTERVAL pickup_delay MINUTE
    ),

    distance_km,
    duration_min,

    ROUND(
        (base_fare + distance_km * rate_per_km)
        * surge_multiplier - discount,
        2
    )

FROM (
    SELECT
        R.ride_id,

        10001
        + FLOOR(RAND() * 2000) * 3
        + CASE R.vehicle_type
            WHEN 'Bike' THEN 0
            WHEN 'Auto' THEN 1
            ELSE 2
          END AS driver_id,

        DATE_ADD(
            R.request_time,
            INTERVAL FLOOR(1 + RAND() * 8) MINUTE
        ) AS accept_time,

        FLOOR(2 + RAND() * 14) AS pickup_delay,

        ROUND(1 + RAND() * 24, 2) AS distance_km,

        ROUND(5 + RAND() * 55, 2) AS duration_min,

        CASE R.vehicle_type
            WHEN 'Bike' THEN 8
            WHEN 'Auto' THEN 12
            ELSE 18
        END AS rate_per_km,

        P.base_fare,
        P.surge_multiplier,
        P.discount

    FROM RIDES R

    JOIN PRICING P
        ON R.ride_id = P.ride_id

    WHERE R.ride_status = 'Completed'

) AS trip_data;

INSERT INTO CANCELLATIONS
(ride_id, cancelled_by, cancel_reason)

SELECT
    ride_id,

    cancelled_by,

    CASE
        WHEN cancelled_by = 'Customer'
        THEN ELT(
            FLOOR(1 + RAND() * 4),
            'High waiting time',
            'Changed travel plan',
            'High fare',
            'Booked another ride'
        )

        ELSE ELT(
            FLOOR(1 + RAND() * 4),
            'Long pickup distance',
            'Traffic conditions',
            'Vehicle issue',
            'Low earnings'
        )
    END

FROM (
    SELECT
        ride_id,

        ELT(
            FLOOR(1 + RAND() * 2),
            'Customer',
            'Driver'
        ) AS cancelled_by

    FROM RIDES

    WHERE ride_status = 'Cancelled'

) AS cancelled_rides;

SELECT COUNT(*) AS total_drivers
FROM DRIVERS;

SELECT COUNT(*) AS total_rides
FROM RIDES;

SELECT COUNT(*) AS total_trips
FROM TRIPS;

SELECT COUNT(*) AS total_pricing_records
FROM PRICING;

SELECT COUNT(*) AS total_cancellations
FROM CANCELLATIONS;

SELECT
    vehicle_type,
    COUNT(*) AS total_drivers,
    ROUND(AVG(rating), 2) AS average_rating,
    ROUND(AVG(online_hours), 2) AS average_online_hours
FROM DRIVERS
GROUP BY vehicle_type;  

SELECT
    pickup_area,
    COUNT(*) AS total_bookings
FROM RIDES
GROUP BY pickup_area
ORDER BY total_bookings DESC;  

SELECT
    pickup_area,
    COUNT(*) AS total_bookings
FROM RIDES
GROUP BY pickup_area
ORDER BY total_bookings DESC;  

SELECT
    cancelled_by,
    cancel_reason,
    COUNT(*) AS total_cancellations
FROM CANCELLATIONS
GROUP BY cancelled_by, cancel_reason
ORDER BY total_cancellations DESC;  

SELECT
    P.surge_multiplier,
    COUNT(*) AS total_bookings,

    SUM(
        CASE WHEN R.ride_status = 'Completed'
        THEN 1 ELSE 0 END
    ) AS completed_rides,

    SUM(
        CASE WHEN R.ride_status = 'Cancelled'
        THEN 1 ELSE 0 END
    ) AS cancelled_rides

FROM RIDES R

JOIN PRICING P
    ON R.ride_id = P.ride_id

GROUP BY P.surge_multiplier
ORDER BY P.surge_multiplier;

USE ZIPRIDE_ANALYTICS_DB;
SELECT*FROM DRIVERS;
USE ZIPRIDE_6000_DB;
SELECT*FROM DRIVERS;

SELECT * FROM RIDES;
SELECT * FROM TRIPS;
SELECT * FROM PRICING;
SELECT * FROM CANCELLATIONS;
show tables;
desc drivers;
desc pricing;