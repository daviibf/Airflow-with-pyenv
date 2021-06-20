#!/bin/bash

# Get Docker ID
dockerid=$(docker ps -qf "name=airflow")

# BELOW THE PROCESS OF INSTALLING AND PREPARING THE ENVIRONMENT

docker exec $dockerid bash -c "/opt/airflow/.pyenv/bin/pyenv install 3.6.9 -s"

docker exec $dockerid bash -c "cd /opt/airflow/dags/scripts/project1/ ; /opt/airflow/.pyenv/bin/pyenv local 3.6.9"

docker exec $dockerid bash -c "cd /opt/airflow/dags/scripts/project1/ ; /opt/airflow/.pyenv/shims/python -m venv py369"

docker exec $dockerid bash -c "cd /opt/airflow/dags/scripts/project1/ ; source py369/bin/activate ; pip install -r requirements.txt"

# Essa linha abaixo é para resolver um problema que as vezes acontece
# quando trocamos de versão de python. Pra evitar que o airflow fique confuso
# nós precisamos recompilar os *.pyc
# https://stackoverflow.com/questions/514371/whats-the-bad-magic-number-error

docker exec $dockerid bash -c "find . -name '*.pyc' -delete"

# References :
# https://opensource.com/article/20/4/pyenv
# https://devconnected.com/docker-exec-command-with-examples/
# https://linuxize.com/post/how-to-create-directories-in-linux-with-the-mkdir-command/
# https://stackoverflow.com/questions/514371/whats-the-bad-magic-number-error