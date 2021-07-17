#!/usr/bin/env bash

# RUN BEFORE ALL
# echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=0" > .env

# Install pyenv
curl https://pyenv.run | bash

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

# install python 3.6.9 from pyenv
/opt/airflow/.pyenv/bin/pyenv install 3.6.9 -s

# Update the bash for pyrnv
source ~/.bashrc

# Start the rsyslog with sudo command.
# echo <password> | sudo -S <command>
echo airflow | sudo -S service rsyslog start

# Initiliase the metastore
airflow db init

# Run the scheduler in background
airflow scheduler &> /dev/null &

# Create user
#airflow users create -u admin -p admin -r Admin -e admin@admin.com -f admin -l admin
airflow users create -e "admin@airflow.com" -f "mobit" -l "pdi" -p "pdi@mobit" -r "Admin" -u "mobit"

# Run the web server in foreground (for docker logs)
exec airflow webserver
