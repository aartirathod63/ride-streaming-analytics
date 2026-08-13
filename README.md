# 🚕 Ride Streaming Analytics — Pune

An end-to-end data engineering project that simulates a ride-streaming pipeline, processes ride events using Python, stores them in MySQL, performs SQL analytics and data-quality checks, and visualizes business insights through Tableau Public.

## 📊 Interactive Dashboard

**[View the Tableau Public Dashboard](https://public.tableau.com/app/profile/aarti.rathod2366/viz/Ride_Streaming_Data/RideStreamingAnalyticsPune?publish=yes)**

The dashboard provides insights into:

* Total revenue
* Total rides
* Average fare
* Cancellation rate
* Revenue by route
* Revenue by payment method
* Ride demand by hour

## 🏗️ Architecture

```text
Ride Event Data
      ↓
JSONL Event Stream
      ↓
Python Stream Processor
      ↓
MySQL Database
      ↓
SQL Analytics & Data Quality
      ↓
Dashboard Dataset
      ↓
Tableau Public
```

## 🛠️ Tech Stack

* **Python** — Event processing and ETL
* **Pandas** — Data transformation
* **MySQL** — Data storage and analytics
* **SQL** — Business analysis and data-quality checks
* **Tableau Public** — Data visualization
* **Git & GitHub** — Version control

## 📁 Project Structure

```text
ride-streaming-analytics/
│
├── data/
│   ├── ride_events.jsonl
│   ├── ride_dashboard.csv
│   ├── ride_dashboard.tsv
│   ├── customers.csv
│   ├── drivers.csv
│   ├── payments.csv
│   └── rides.csv
│
├── sql/
│   ├── analytics.sql
│   └── data_quality.sql
│
├── src/
│   ├── generate_events.py
│   └── stream_processor.py
│
├── tableau/
│   └── Ride_Streaming_Data.twb
│
├── tests/
├── requirements.txt
└── README.md
```

## 🔄 Pipeline

### 1. Event Generation

Ride events are generated in JSONL format to simulate streaming ride data.

Each event contains information such as:

* Trip ID
* Driver ID
* Customer ID
* Pickup and drop locations
* Distance
* Fare
* Payment method
* Trip status
* Event timestamp

### 2. Stream Processing

Python processes the incoming ride events and calculates derived metrics such as:

```text
fare_per_km = fare_amount / distance_km
```

Processed events are loaded into MySQL.

### 3. MySQL Storage

The processed events are stored in the `ride_events` table.

The table contains:

* `trip_id`
* `driver_id`
* `customer_id`
* `pickup_location`
* `drop_location`
* `distance_km`
* `fare_amount`
* `fare_per_km`
* `payment_method`
* `trip_status`
* `event_timestamp`

### 4. SQL Analytics

SQL queries calculate key business metrics including:

* Total rides
* Completed rides
* Cancelled rides
* Cancellation rate
* Total revenue
* Average fare
* Revenue by route
* Revenue by payment method
* Ride activity by hour

### 5. Data Quality

Data-quality checks validate:

* Missing values
* Duplicate trip IDs
* Invalid fares
* Invalid distances
* Invalid trip statuses
* Invalid payment methods

All implemented data-quality checks returned **0 issues** for the current dataset.

## 📈 Key Results

Current dataset contains:

| Metric            |    Result |
| ----------------- | --------: |
| Total rides       |        28 |
| Completed rides   |        21 |
| Cancelled rides   |         7 |
| Cancellation rate |       25% |
| Total revenue     | ₹8,485.18 |
| Average fare      |   ₹303.04 |

## 📊 Tableau Dashboard

The Tableau dashboard provides an interactive view of the processed ride data.

### Dashboard Components

**KPI Cards**

* Total Revenue
* Total Rides
* Average Fare
* Cancellation Rate

**Visualizations**

* Revenue by Route
* Revenue by Payment Method
* Rides by Hour

[Open the Interactive Tableau Dashboard](https://public.tableau.com/app/profile/aarti.rathod2366/viz/Ride_Streaming_Data/RideStreamingAnalyticsPune?publish=yes)

## 🚀 How to Run

### Clone the repository

```bash
git clone https://github.com/aartirathod63/ride-streaming-analytics.git
cd ride-streaming-analytics
```

### Create a virtual environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### Install dependencies

```bash
pip install -r requirements.txt
```

### Run the event processing pipeline

```bash
python src/stream_processor.py
```

### Run SQL analytics

```bash
mysql -u root -p ride_streaming < sql/analytics.sql
```

### Run data-quality checks

```bash
mysql -u root -p ride_streaming < sql/data_quality.sql
```

## 🎯 Project Objective

The goal of this project is to demonstrate an end-to-end data engineering workflow:

**Ingestion → Processing → Storage → Transformation → Data Quality → Analytics → Visualization**

This project demonstrates practical experience with Python, SQL, MySQL, ETL concepts, data validation, Git, and BI visualization.

## 👩‍💻 Author

**Aarti Rathod**

Data Engineer | Python | SQL | Data Engineering | Analytics

[GitHub](https://github.com/aartirathod63)
