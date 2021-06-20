#!/usr/bin/env bash

curl https://pyenv.run | bash

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

source ~/.bashrc

# Initiliase the metastore
airflow db init

# Run the scheduler in background
airflow scheduler &> /dev/null &

# Create user
#airflow users create -u admin -p admin -r Admin -e admin@admin.com -f admin -l admin
airflow users create -e "admin@airflow.com" -f "mobit" -l "pdi" -p "pdi@mobit" -r "Admin" -u "mobit"

# Run the web server in foreground (for docker logs)
exec airflow webserver
