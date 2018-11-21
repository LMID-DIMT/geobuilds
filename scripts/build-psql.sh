#!/bin/bash

PGIS_URL=https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm

# update packages
echo "Update packages..."
sleep 3s
sudo yum -y update

# download latest epel release
echo "Install latest EPEL release"
sleep 3s
sudo yum -y install epel-release

# download postgresql 10 rpm
echo "Download PostgreSQL 10 RPM"
sleep 3s
wget $PGIS_URL
sudo rpm -Uvh pgdg-centos10-10-2.noarch.rpm

# install postgresql, postgis, pgrouting
echo "Install PostgreSQL, PostGIS and Pgrouting"
sleep 3s
sudo yum -y install postgresql10 postgresql10-server postgresql10-contrib postgis24_10 postgis24_10-utils pgrouting_10

# enable postgresql
echo "Enable PostgreSQL"
sleep 3s
sudo systemctl enable postgresql-10

# initialize postgresql database
echo "Initialize PostgreSQL database"
sleep 3s
sudo /usr/pgsql-10/bin/postgresql-10-setup initdb

# start postgresql service
echo "Start PostgreSQL"
sleep 3s
sudo systemctl start postgresql-10.service

# make sure postgresql start on machine startup
echo "Enable PostgreSQL on machine startup"
sleep 3s
sudo systemctl enable postgresql-10.service
