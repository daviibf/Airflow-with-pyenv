#!/bin/bash

find . -name "*.pyc" -delete
cd /opt/airflow/dags/projects/example_project/
source py369/bin/activate
python example_script.py
