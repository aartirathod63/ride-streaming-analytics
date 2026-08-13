import json
import random
import time
from datetime import datetime

from faker import Faker

fake = Faker()

LOCATIONS = [
    "Kharadi",
    "Viman Nagar",
    "Hinjewadi",
    "Baner",
    "Wakad",
    "Koregaon Park",
    "Hadapsar",
    "Shivajinagar",
    "Aundh",
    "Kalyani Nagar",
]

PAYMENT_METHODS = ["UPI", "Cash", "Card", "Wallet"]

TRIP_STATUSES = [
    "Completed",
    "Completed",
    "Completed",
    "Cancelled",
]


def generate_trip_event():
    pickup = random.choice(LOCATIONS)

    drop = random.choice(
        [location for location in LOCATIONS if location != pickup]
    )

    distance = round(random.uniform(1.5, 30.0), 2)

    fare = round(50 + distance * random.uniform(12, 22), 2)

    return {
        "trip_id": fake.uuid4(),
        "driver_id": random.randint(1001, 1050),
        "customer_id": random.randint(2001, 2200),
        "pickup_location": pickup,
        "drop_location": drop,
        "distance_km": distance,
        "fare_amount": fare,
        "payment_method": random.choice(PAYMENT_METHODS),
        "trip_status": random.choice(TRIP_STATUSES),
        "event_timestamp": datetime.now().isoformat(),
    }


if __name__ == "__main__":

    print("🚕 Starting real-time ride event generator...\n")

    while True:
        event = generate_trip_event()

        print(json.dumps(event))

        with open("data/ride_events.jsonl", "a") as file:
            file.write(json.dumps(event) + "\n")

        time.sleep(2)