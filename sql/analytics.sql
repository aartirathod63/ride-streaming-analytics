USE ride_streaming;

-- 1. Overall ride metrics
SELECT
    COUNT(*) AS total_rides,
    ROUND(SUM(fare_amount), 2) AS total_revenue,
    ROUND(AVG(fare_amount), 2) AS average_fare,
    ROUND(AVG(distance_km), 2) AS average_distance_km,
    ROUND(AVG(fare_per_km), 2) AS average_fare_per_km
FROM ride_events;


-- 2. Revenue by pickup location
SELECT
    pickup_location,
    COUNT(*) AS total_rides,
    ROUND(SUM(fare_amount), 2) AS total_revenue,
    ROUND(AVG(fare_per_km), 2) AS avg_fare_per_km
FROM ride_events
WHERE trip_status = 'completed'
GROUP BY pickup_location
ORDER BY total_revenue DESC;


-- 3. Most popular routes
SELECT
    pickup_location,
    drop_location,
    COUNT(*) AS trip_count,
    ROUND(SUM(fare_amount), 2) AS total_revenue
FROM ride_events
WHERE trip_status = 'completed'
GROUP BY pickup_location, drop_location
ORDER BY trip_count DESC;


-- 4. Most profitable routes
SELECT
    pickup_location,
    drop_location,
    COUNT(*) AS trip_count,
    ROUND(SUM(fare_amount), 2) AS total_revenue,
    ROUND(AVG(fare_per_km), 2) AS avg_fare_per_km
FROM ride_events
WHERE trip_status = 'completed'
GROUP BY pickup_location, drop_location
HAVING trip_count >= 1
ORDER BY total_revenue DESC;


-- 5. Payment method analysis
SELECT
    payment_method,
    COUNT(*) AS total_rides,
    ROUND(SUM(fare_amount), 2) AS total_revenue,
    ROUND(AVG(fare_amount), 2) AS average_fare
FROM ride_events
WHERE trip_status = 'completed'
GROUP BY payment_method
ORDER BY total_revenue DESC;


-- 6. Driver performance
SELECT
    driver_id,
    COUNT(*) AS total_rides,
    ROUND(SUM(fare_amount), 2) AS total_revenue,
    ROUND(AVG(fare_per_km), 2) AS avg_fare_per_km
FROM ride_events
WHERE trip_status = 'completed'
GROUP BY driver_id
ORDER BY total_revenue DESC;


-- 7. Cancellation rate
SELECT
    COUNT(*) AS total_trips,
    SUM(trip_status = 'completed') AS completed_trips,
    SUM(trip_status = 'cancelled') AS cancelled_trips,
    ROUND(
        100 * SUM(trip_status = 'cancelled') / COUNT(*),
        2
    ) AS cancellation_rate_percent
FROM ride_events;