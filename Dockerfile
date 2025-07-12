FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        gnupg2 \
        lsb-release \
        ca-certificates \
        sudo \
        python3 \
        python3-pip \
        python3-venv \
        python3-psutil \
        python3-requests \
        python3-setuptools \
        python3-ldap \
        python3-cryptography \
        python3-jinja2 \
        python3-jsonschema \
        python3-yaml \
        python3-pkg-resources \
        python3-psycopg2 \
        python3-mysqldb \
        python3-pymysql \
        python3-pymongo \
        python3-pyodbc \
        python3-pytest \
        python3-coverage \
        python3-wheel \
        python3-dev \
        build-essential \
        libssl-dev \
        libxml2-dev \
        libcurl4-openssl-dev \
        libfuse-dev \
        libkrb5-dev \
        libpam0g-dev \
        libpq-dev \
        libmysqlclient-dev \
        unixodbc-dev \
        odbcinst \
        odbc-postgresql \
        postgresql-client \
        curl \
        git \
        bison \
        flex \
        cmake \
        make \
        iputils-ping \
        && rm -rf /var/lib/apt/lists/*

# Install iRODS dependencies
RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/renci-irods.list && \
    apt-get update && \
    apt-get install -y \
        irods-server \
        irods-database-plugin-postgres

# Set up a user for iRODS
RUN useradd -m irods && \
    usermod -aG sudo irods && \
    echo "irods ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Copy initialization scripts
COPY database_init.sh /root/database_init.sh
COPY unattended.json /root/unattended.json

WORKDIR /root