#!/bin/bash
# This script installs PostgreSQL version 10 along with spatial extensions PostGIS and Pgrouting

# set PostgreSQL url
# alternative PostgreSQL versions can be found here https://download.postgresql.org/pub/repos/yum/
PSQL_URL=https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
PSQL_RPM=pgdg-centos10-10-2.noarch.rpm

PSQL_VER=postgresql10
PSQL_EN=postgresql-10
PGIS_VER=postgis24_10
PGRT_VER=pgrouting_10

PSQL_LOC=/usr/pgsql-10

# download postgresql 10 rpm
echo "Download PostgreSQL 10 RPM"
sleep 3s
wget $PSQL_URL
sudo rpm -Uvh $PSQL_RPM

# install postgresql, postgis, pgrouting
echo "Install PostgreSQL, PostGIS and Pgrouting"
sleep 3s
sudo yum -y install $PSQL_VER $PSQL_VER-server $PSQL_VER-contrib $PGIS_VER $PGIS_VER-utils $PGRT_VER

# enable postgresql
echo "Enable PostgreSQL"
sleep 3s
sudo systemctl enable $PSQL_EN

# initialize postgresql database
echo "Initialize PostgreSQL database"
sleep 3s
sudo $PSQL_LOC/bin/$PSQL_EN-setup initdb

# start postgresql service
echo "Start PostgreSQL"
sleep 3s
sudo systemctl start $PSQL_EN.service

# make sure postgresql start on machine startup
echo "Enable PostgreSQL on machine startup"
sleep 3s
sudo systemctl enable $PSQL_EN.service
