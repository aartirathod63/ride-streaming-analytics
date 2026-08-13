USE ride_streaming;

-- 1. Overall ride metrics
SELECT
    COUNT(*) AS total_rides,
    ROUND(SUM(fare_amount), 2) AS total_revenue,
    ROUND(AVG(fare_amount), 2) AS average_fare,
    ROUND(AVG(distance_km), 2) AS average_distance_km,
    ROUND(AVG(fare_per_km), 2) AS average_fare_per_km
FROM ride_events
WHERE trip_status = 'Completed';


-- 2. Ride status distribution
SELECT
    trip_status,
    COUNT(*) AS ride_count
FROM ride_events
GROUP BY trip_status
ORDER BY ride_count DESC;


-- 3. Revenue by pickup location
SELECT
    pickup_location,
    COUNT(*) AS total_rides,
    ROUND(SUM(fare_amount), 2) AS total_revenue,
    ROUND(AVG(fare_amount), 2) AS average_fare
FROM ride_events
WHERE trip_status = 'Completed'
GROUP BY pickup_location
ORDER BY total_revenue DESC;


-- 4. Most popular routes
SELECT
    pickup_location,
    drop_location,
    COUNT(*) AS ride_count,
    ROUND(SUM(fare_amount), 2) AS revenue
FROM ride_events
WHERE trip_status = 'Completed'
GROUP BY
    pickup_location,
    drop_location
ORDER BY ride_count DESC;


-- 5. Most profitable routes
SELECT
    pickup_location,
    drop_location,
    COUNT(*) AS ride_count,
    ROUND(SUM(fare_amount), 2) AS revenue,
    ROUND(AVG(fare_per_km), 2) AS avg_fare_per_km
FROM ride_events
WHERE trip_status = 'Completed'
GROUP BY
    pickup_location,
    drop_location
ORDER BY revenue DESC;


-- 6. Payment method analysis
SELECT
    payment_method,
    COUNT(*) AS ride_count,
    ROUND(SUM(fare_amount), 2) AS revenue
FROM ride_events
WHERE trip_status = 'Completed'
GROUP BY payment_method
ORDER BY revenue DESC;


-- 7. Highest-value rides
SELECT
    trip_id,
    pickup_location,
    drop_location,
    distance_km,
    fare_amount,
    fare_per_km
FROM ride_events
WHERE trip_status = 'Completed'
ORDER BY fare_amount DESC
LIMIT 10;


-- 8. Driver performance
SELECT
    driver_id,
    COUNT(*) AS completed_rides,
    ROUND(SUM(fare_amount), 2) AS revenue,
    ROUND(AVG(fare_amount), 2) AS average_fare,
    ROUND(AVG(fare_per_km), 2) AS average_fare_per_km
FROM ride_events
WHERE trip_status = 'Completed'
GROUP BY driver_id
ORDER BY revenue DESC;


-- 9. Cancellation analysis
SELECT
    COUNT(*) AS total_rides,
    SUM(trip_status = 'Cancelled') AS cancelled_rides,
    ROUND(
        100 * SUM(trip_status = 'Cancelled') / COUNT(*),
        2
    ) AS cancellation_rate_percent
FROM ride_events;