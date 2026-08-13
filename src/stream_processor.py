import json
import time
import os
from pathlib import Path

import mysql.connector
from dotenv import load_dotenv

load_dotenv()

DB_CONFIG = {
    "host": os.getenv("DB_HOST"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "database": os.getenv("DB_NAME"),
}



import json
import time
from pathlib import Path

import mysql.connector


EVENT_FILE = Path("data/ride_events.jsonl")

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "Aarti@123",
    "database": "ride_streaming",
}


REQUIRED_FIELDS = [
    "trip_id",
    "driver_id",
    "customer_id",
    "pickup_location",
    "drop_location",
    "distance_km",
    "fare_amount",
    "payment_method",
    "trip_status",
    "event_timestamp",
]


def validate_event(event):
    """Validate a ride event before processing."""

    for field in REQUIRED_FIELDS:
        if field not in event:
            return False, f"Missing field: {field}"

    if event["distance_km"] <= 0:
        return False, "Invalid distance"

    if event["fare_amount"] <= 0:
        return False, "Invalid fare"

    if event["trip_status"] not in {
        "Completed",
        "Cancelled",
    }:
        return False, "Invalid trip status"

    return True, "Valid"


def process_event(event):
    """Add derived metrics."""

    event["fare_per_km"] = round(
        event["fare_amount"] / event["distance_km"],
        2
    )

    return event


def insert_event(connection, event):
    """Insert processed event into MySQL."""

    query = """
        INSERT INTO ride_events (
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
            event_timestamp
        )
        VALUES (
            %s, %s, %s, %s, %s,
            %s, %s, %s, %s, %s, %s
        )
    """

    values = (
        event["trip_id"],
        event["driver_id"],
        event["customer_id"],
        event["pickup_location"],
        event["drop_location"],
        event["distance_km"],
        event["fare_amount"],
        event["fare_per_km"],
        event["payment_method"],
        event["trip_status"],
        event["event_timestamp"],
    )

    cursor = connection.cursor()

    try:
        cursor.execute(query, values)
        connection.commit()

    except mysql.connector.Error as error:
        connection.rollback()
        print(f"❌ Database error: {error}")

    finally:
        cursor.close()


def stream_events():

    print("📡 Starting ride stream processor...\n")

    connection = mysql.connector.connect(**DB_CONFIG)

    print("✅ Connected to MySQL\n")

    with open(EVENT_FILE, "r") as file:

        for line in file:

            event = json.loads(line)

            is_valid, message = validate_event(event)

            if not is_valid:
                print(f"❌ Invalid event: {message}")
                continue

            processed_event = process_event(event)

            insert_event(
                connection,
                processed_event
            )

            print(
                f"✅ Loaded trip "
                f"{processed_event['trip_id']} | "
                f"{processed_event['pickup_location']} → "
                f"{processed_event['drop_location']} | "
                f"₹{processed_event['fare_amount']} | "
                f"₹{processed_event['fare_per_km']}/km"
            )

            time.sleep(0.5)

    connection.close()

    print("\n🏁 Stream processing completed.")


if __name__ == "__main__":
    stream_events()