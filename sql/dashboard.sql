USE ride_streaming;

CREATE OR REPLACE VIEW ride_dashboard AS
SELECT
    trip_id,
    driver_id,
    customer_id,
    pickup_location,
    drop_location,
    distance_km,
    fare_amount,
    fare_per_km,
    payment_method,
    trip_status,
    event_timestamp,
    DATE(event_timestamp) AS ride_date,
    HOUR(event_timestamp) AS ride_hour,
    CONCAT(pickup_location, ' → ', drop_location) AS route
FROM ride_events;