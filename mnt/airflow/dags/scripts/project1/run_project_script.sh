#!/bin/bash

find . -name "*.pyc" -delete
cd /opt/airflow/dags/scripts/project1/
source py369/bin/activate
python project_script.py
#deactivate