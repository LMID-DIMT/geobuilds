#!/bin/bash
# This shell script installs Java 8 jdk along with GeoServer version 2.13.0

# set your non-root user
USER=user

# set Java variables
# alternative Java version downloads can be found here https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
JAVA_URL=https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz
JAVA_DIR=jdk1.8.0_191
JAVA_TAR=jdk-8u191-linux-x64.tar.gz

# set GeoServer variables
GEOSERVER_URL=https://sourceforge.net/projects/geoserver/files/GeoServer/2.13.0/geoserver-2.13.0-bin.zip
GEOSERVER_VER=geoserver-2.13.0
PORT=9400

# install Oracle Java 8 JDK and set the home directories in ~/.bashrc
echo "Install Oracle Java 8 JDK"
sleep 3s
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "$JAVA_URL"
tar xzf $JAVA_TAR
mv $JAVA_DIR /usr/local/
sudo -u $USER ./bashrc.sh
source ~/.bashrc

# download geoserver source code
echo "Download GeoServer source code"
sleep 3s
wget $GEOSERVER_URL

# unpack GeoServer and set the home directory in ~/.bashrc
echo "Unpack GeoServer"
sleep 3s
unzip $GEOSERVER_VER-bin.zip
mv $GEOSERVER_VER geoserver
mv geoserver /usr/local/
chown $USER /usr/local/geoserver/
runuser -l $USER -c 'echo "export GEOSERVER_HOME=/usr/local/geoserver/" >> ~/.bashrc'
source ~/.bashrc

# set the GeoServer port number and enable it through firewalld
echo "Set GeoServer port number"
sleep 3s
sed -i "s/jetty.port=8080/jetty.port=$PORT/g" /usr/local/geoserver/start.ini
systemctl restart firewalld.service
firewall-cmd --permanent --add-port=$PORT/tcp
firewall-cmd --reload
