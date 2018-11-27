# geobuilds

*In development*

## /scripts
A series of shell scripts that will install OSGeo projects (PostgreSQL/PostGIS, GeoServer) on a fresh CentOS 7 install.

### build-pgsql.sh
This shell script will install PostgreSQL 10 along with spatial extensions PostGIS and Pgrouting.

Alternative version options for [PostgreSQL](https://download.postgresql.org/pub/repos/yum/).

If you plan on using an alternative PostgreSQL version, be sure to edit the shell script variables appropriately. For example, if you decide to use PostgreSQL 11 rather than 10...

```
PSQL_URL=https://download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/pgdg-centos11-11-2.noarch.rpm
PSQL_RPM=pgdg-centos11-11-2.noarch.rpm

PSQL_VER=postgresql11
PGIS_VER=postgis24_11
PGRT_VER=pgrouting_11

PSQL_LOC=/usr/pgsql-11
```

#### Get Started
```
$ sudo yum install epel-release
$ sudo yum update
$ cd scripts
$ sudo chmod +x build-pgsql.sh
$ sudo ./build-pgsql.sh
```
Usually running shell scripts with `sudo` is not recommended, [however there are proper ways of doing this](https://bitmingw.com/2017/01/22/use-sudo-in-scripts/).

#### Upon Completion
Check PostgreSQL version.

```
$ psql -V
psql (PostgreSQL) 10.6
```

### build-geoserver.sh
This shell script will install Oracle Java 8 JDK and GeoServer

Alternative version options for [Oracle Java JDK](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) and [GeoServer](https://sourceforge.net/projects/geoserver/files/).

If you plan on using alternative Oracle Java JDK and GeoServer versions, be sure to edit the shell script variables appropriately. However, Oracle Java 8 JDK and GeoServer 2.13.0 are compatible with one another.

```
JAVA_URL=https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz
JAVA_HOME=/usr/local/jdk1.8.0_191
JAVA_TAR=jdk-8u191-linux-x64.tar.gz

GEOSERVER_URL=https://sourceforge.net/projects/geoserver/files/GeoServer/2.13.0/geoserver-2.13.0-bin.zip
GEOSERVER_VER=geoserver-2.13.0
PORT=9400
```

#### Get Started
```
$ sudo yum install epel-release
$ sudo yum update
$ cd scripts
$ sudo chmod +x build-geoserver.sh
$ sudo ./build-geoserver.sh
```
Usually running shell scripts with `sudo` is not recommended, [however there are proper ways of doing this](https://bitmingw.com/2017/01/22/use-sudo-in-scripts/).

#### Upon Completion
Once the shell script has completed, open a web browser and type `http://localhost:9400/geoserver/web` to view the GeoServer administrative interface.

Use the `alternatives` command to set the default Java version.

In this case, the newly installed Java version is selection `2`.

```
$ sudo alternatives --config java


There are 2 programs which provide 'java'.

  Selection    Command
-----------------------------------------------
*+ 1           java-1.8.0-openjdk.x86_64 (/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-11.b12.el7.x86_64/jre/bin/java)
   2           /usr/java/jdk1.8.0_191-amd64/jre/bin/java

Enter to keep the current selection[+], or type selection number: 2

$ java -version

java version "1.8.0_191"
Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
```

## /service
A series of CentOS service files to easily manage OSGeo projects.

### geoserver
A service file which will allow you to `start, stop, restart` and check the `status` of your new GeoServer instance.

```
$ sudo cp service/geoserver /etc/init.d/
$ sudo chmod +x /etc/init.d/geoserver/
$ sudo service geoserver start

Starting geoserver…
geoserver is started

$ sudo service geoserver stop

Stopping geoserver…
8449
geoserver has stopped

$ sudo service geoserver restart

geoserver is not running
Starting geoserver…
geoserver is started

$ sudo service geoserver status

Checking geoserver...                             geoserver is running
```
