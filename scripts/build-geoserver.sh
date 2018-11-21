#!/bin/bash

GEOSERVER_URL=https://sourceforge.net/projects/geoserver/files/GeoServer/2.13.0/geoserver-2.13.0-bin.zip
GEOSERVER_VER=geoserver-2.13.0
PORT=9400

# download geoserver source code
echo "Download GeoServer source code"
sleep 3s
wget $GEOSERVER_URL

echo "Unpack GeoServer"
sleep 3s
unzip $GEOSERVER_VER-bin.zip
mv $GEOSERVER_VER geoserver
sudo mv geoserver /usr/local/
sudo chown $USER /usr/local/geoserver/
echo "export GEOSERVER_HOME=/usr/local/geoserver/" >> ~/.bashrc
source ~/.bashrc

echo "Set GeoServer port number"
sleep 3s
sudo sed -i "s/jetty.port=8080/jetty.port=$PORT/g" /usr/local/geoserver/start.ini
sudo systemctl start firewalld.service
sudo firewall-cmd --permanent --add-port=$PORT/tcp
sudo firewall-cmd --reload

echo "Start GeoServer"
sleep 3s
sudo chmod +x /usr/local/geoserver/bin/startup.sh
/usr/local/geoserver/bin/startup.sh
