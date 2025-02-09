FROM apache/airflow:slim-2.10.4-python3.12

# Copy the DAGs directory to the Airflow home directory
COPY dags/ /opt/airflow/dags/

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Switch to the root user to change permissions
USER root
RUN chmod +x /entrypoint.sh

# Switch back to the airflow user
USER airflow

# Set the entrypoint to the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]