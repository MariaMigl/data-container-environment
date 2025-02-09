#!/usr/bin/env bash

echo "Initializing the Airflow database..."
airflow db init

echo "Creating admin user..."
airflow users create \
    --username maria \
    --firstname maria \
    --lastname almeida \
    --role Admin \
    --email maria@mail.com \
    --password mariapassword

echo "Starting $1..."
exec airflow "$1"