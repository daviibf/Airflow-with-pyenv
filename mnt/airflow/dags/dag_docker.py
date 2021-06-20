from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta


default_args = {
            "owner": "airflow",
            "start_date": datetime(2021, 1, 1),
            "depends_on_past": False,
            "email_on_failure": True,
            "email_on_retry": False,
            "email": "youremail@host.com",
            "retries": 1,
            "retry_delay": timedelta(minutes=5)
        }

# A DAG schedule to run every 5min a bash script responsible for activating the pyenv and running the project_script.py
with DAG(dag_id="dag-container", schedule_interval="*/5 * * * *", default_args=default_args, catchup=False) as dag:

    exec_bash = BashOperator(
        task_id='exec_bash',
        bash_command='{{"/opt/airflow/dags/scripts/project1/run_project_script.sh"}}'
    )

    # Testar Dag via CMD
    # airflow tasks test dag-container exec_bash 2021-01-01