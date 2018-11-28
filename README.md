# geobuilds

*In development*

## /scripts

A series of shell scripts that will install OSGeo projects (PostgreSQL/PostGIS, GeoServer) on a fresh CentOS 7 install.

### Prerequisites

Install epel-release for CentOS 7 and update packages.

```
$ sudo yum install epel-release
$ sudo yum update
$ sudo yum install wget nano git unzip
```

Clone the `geobuilds` repository.

```
$ git clone https://github.com/LMID-DIMT/geobuilds
```

#### build-pgsql.sh

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

##### Get Started

```
$ cd scripts
$ sudo chmod +x build-pgsql.sh
$ sudo ./build-pgsql.sh
```

Usually running shell scripts with `sudo` is not recommended, [however there are proper ways of doing this](https://bitmingw.com/2017/01/22/use-sudo-in-scripts/). Running these scripts with `sudo` will avoid the user continually entering root passwords.

##### Upon Completion

Check PostgreSQL version.

```
$ psql -V
psql (PostgreSQL) 10.6
```

#### build-geoserver.sh

This shell script will install Oracle Java 8 JDK and GeoServer

Alternative version options for [Oracle Java JDK](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) and [GeoServer](https://sourceforge.net/projects/geoserver/files/).

If you plan on using alternative Oracle Java JDK and GeoServer versions, be sure to edit the shell script variables appropriately. However, Oracle Java 8 JDK and GeoServer 2.13.0 are compatible with one another.


```
# set your non-root user
USER="USERNAME"

# set Java variables
# alternative Java version downloads can be found here https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
JAVA_URL=https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz
JAVA_DIR=jdk1.8.0_191
JAVA_TAR=jdk-8u191-linux-x64.tar.gz

# set GeoServer variables
GEOSERVER_URL=https://sourceforge.net/projects/geoserver/files/GeoServer/2.13.0/geoserver-2.13.0-bin.zip
GEOSERVER_VER=geoserver-2.13.0
PORT=9400
```

##### Get Started

```
$ cd scripts
$ sudo chmod +x bashrc.sh
$ sudo chmod +x build-geoserver.sh
$ sudo ./build-geoserver.sh
```

Usually running shell scripts with `sudo` is not recommended, [however there are proper ways of doing this](https://bitmingw.com/2017/01/22/use-sudo-in-scripts/). Running these scripts with `sudo` will avoid the user continually entering root passwords.

##### Upon Completion

When the script has completed, `exit` the shell and open a new one. Check Java version.

```
$ java -version

java version "1.8.0_191"
Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
```

Start Geoserver.

```
$ /usr/local/geoserver/bin/startup.sh
```

### /service

A series of CentOS service files to easily manage OSGeo projects.

#### geoserver

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
