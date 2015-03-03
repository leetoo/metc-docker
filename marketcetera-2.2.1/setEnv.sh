#!/bin/sh

##
## Set environment variables for the Marketcetera Platform
##
## Future: If messages are an output of this script, then those messages
##         will have to be localized using resource bundles, not hard-coded.
##
## Author: klim@marketcetera.com
## Since: 1.5.0
## Version: $Id: setEnv.sh 16121 2012-01-18 22:03:10Z colin $
##

# Make sure we're not the root user.
if [ "$(id -u)" = "0" ]; then
    echo "This script must not be run as root." 1>&2
    exit 1
fi

export METC_HOME="/metc/marketcetera-2.2.1"

export JAVA_HOME=/etc/alternatives/java
#export MYSQL_HOME=${METC_HOME}/mysql
export ORS_HOME=${METC_HOME}/ors
export UBUNTU_MENUPROXY=0

export PATH=${JAVA_HOME}/bin:${MYSQL_HOME}/bin:${ORDERLOADER_HOME}/bin:${ORS_HOME}/bin:${SA_HOME}/bin:${PATH}

export LD_LIBRARY_PATH=${SA_HOME}/modules/lib:${LD_LIBRARY_PATH}

# MySQL Properties from Installer
export MYSQL_HOST=$MYSQL_PORT_3306_TCP_ADDR
export MYSQL_PORT=3306
export MYSQL_ROOT_PASSWORD=root
