from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago


def print_hello():
    print('Hello World')

# Define the DAG
with DAG(
    'example_dag_1',
    description='A simple print DAG',
    schedule_interval='@daily',
    start_date=days_ago(1),
    catchup=False
) as dag:
    # Define the task using PythonOperator
    hello_task = PythonOperator(
        task_id='hello_task',
        python_callable=print_hello
    )

