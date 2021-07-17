# Base Image
FROM python:3.8-slim
LABEL maintainer="Davi"

# Arguments that can be set with docker build
ARG AIRFLOW_VERSION=2.1.0
ARG AIRFLOW_HOME=/opt/airflow

# Export the environment variable AIRFLOW_HOME where airflow will be installed
ENV AIRFLOW_HOME=${AIRFLOW_HOME}

# Install main SO dependencies and tools
RUN apt-get update -yqq && \
    apt-get upgrade -yqq && \
    apt-get install -yqq --no-install-recommends \ 
    wget \
    sudo \
    libczmq-dev \
    curl \
    libssl-dev \
    git \
    inetutils-telnet \
    bind9utils freetds-dev \
    libkrb5-dev \
    libsasl2-dev \
    libffi-dev libpq-dev \
    freetds-bin build-essential \
    default-libmysqlclient-dev \
    apt-utils \
    rsync \
    zip \
    unzip \
    gcc \
    vim \
    locales \
    rsyslog \
    && apt-get clean

# Install OpenCV Dependencies and other practical packages
RUN apt-get install -yqq --no-install-recommends \ 
    nano \
    ffmpeg \
    libsm6 \
    libxext6 \
    libbz2-dev \
    liblzma-dev \
    iputils-ping \
    nmap \
    net-tools \
    && apt-get clean

# Upgrade pip
# Create airflow user 
# Install apache airflow with subpackages
RUN pip install --upgrade pip && \
    useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow && \
    pip install apache-airflow[postgres]==${AIRFLOW_VERSION} --constraint https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-3.8.txt


# Copy the entrypoint.sh from host to container (at path AIRFLOW_HOME)
COPY ./entrypoint.sh ./entrypoint.sh

# Set the entrypoint.sh file to be executable
RUN chmod +x ./entrypoint.sh

# Define a root password -> user:password
RUN echo "root:root" | chpasswd

# Define a root password -> user:password
RUN echo "airflow:airflow" | chpasswd
RUN usermod -aG sudo airflow

# Set the owner of the files in AIRFLOW_HOME to the user airflow
RUN chown -R airflow: ${AIRFLOW_HOME}

# Set the username to use
USER airflow

# Set workdir (it's like a cd inside the container)
WORKDIR ${AIRFLOW_HOME}

# Create the dags folder which will contain the DAGs
RUN mkdir dags

# Webserver port
EXPOSE 8080

# Execute the entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]