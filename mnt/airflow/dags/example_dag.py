from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta


default_args = {
            "owner": "airflow",
            "start_date": datetime(2021, 1, 1),
            "depends_on_past": False,
            "email_on_failure": False,
            "email_on_retry": False,
            "email": "youremail@host.com",
            "retries": 1,
            "retry_delay": timedelta(minutes=5)
        }

# A DAG aceita CRON Expression. Assim, no schedule_interval abaixo, 
with DAG(dag_id="dag-teste", schedule_interval="*/5 * * * *", default_args=default_args, catchup=False) as dag:

    exec_bash = BashOperator(
        task_id='exec_bash',
        bash_command='{{"/opt/airflow/dags/projects/example_project/run_example.sh"}}'
    )

    exec_bash