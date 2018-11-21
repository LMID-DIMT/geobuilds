#!/bin/bash

GEOSERVER_URL=https://sourceforge.net/projects/geoserver/files/GeoServer/2.13.0/geoserver-2.13.0-bin.zip
GEOSERVER_VER=geoserver-2.13.0
PORT=9400

# update packages
echo "Update packages..."
sleep 3s
sudo yum update -y

# download latest epel release
echo "Install latest EPEL release"
sleep 3s
sudo yum install epel-release -y

# download geoserver source code
echo "Download GeoServer source code"
sleep 3s
wget $GEOSERVER_URL

echo "Unpack GeoServer"
sleep 3s
unzip $GEOSERVER_VER-bin.zip
sudo mv $GEOSERVER_VER-bin /usr/local/
sudo chown $USER /usr/local/$GEOSERVER_VER
echo "export GEOSERVER_HOME=/usr/local/$GEOSERVER_VER" >> .bashrc
source ~/.bashrc

echo "Set GeoServer port number"
sleep 3s
sudo sed -i "s/jetty.port=/jetty.port=$PORT/g" /usr/local/$GEOSERVER_VER/start.ini
firewall-cmd --permanent --add-port=$PORT/tcp
firewall-cmd --reload

echo "Start GeoServer"
sleep 3s
sudo nohup /usr/local/$GEOSERVER_VER/bin/startup.sh "upload" &
