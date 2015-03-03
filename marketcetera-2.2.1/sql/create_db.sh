#!/bin/sh

## 
## Initialize the database for the Marketcetera Platform
##
## Assumptions:
##   This script assumes the bundled MySQL is used.
## 
## Future: If messages are an output of this script, then those messages
##         will have to be localized using resource bundles, not hard-coded.
## 
## Author: klim@marketcetera.com
## Since: 1.5.0
## Version: $Id: create_db.sh 15588 2009-10-02 00:54:17Z klim $
##

. "$(dirname $0)/../setEnv.sh"

echo "--" >> ${METC_HOME}/sql/create_db.log 2>&1
echo "-- `date`" >> ${METC_HOME}/sql/create_db.log 2>&1
echo "--" >> ${METC_HOME}/sql/create_db.log 2>&1

cd ${METC_HOME}/sql
./start_mysql.sh

cd ${METC_HOME}/mysql

./bin/mysql --verbose --host=${MYSQL_HOST} --port=${MYSQL_PORT} --user=root --password=${MYSQL_ROOT_PASSWORD} < ${METC_HOME}/sql/create_db.sql >> ${METC_HOME}/sql/create_db.log 2>&1

./bin/mysql --verbose --host=${MYSQL_HOST} --port=${MYSQL_PORT} --user=marketcetera --password=marketcetera --database=marketcetera < ${METC_HOME}/sql/initialize_db.sql >> ${METC_HOME}/sql/create_db.log 2>&1

cd ${METC_HOME}/sql
./stop_mysql.sh

echo "--" >> ${METC_HOME}/sql/create_db.log 2>&1
echo "-- `date`" >> ${METC_HOME}/sql/create_db.log 2>&1
echo "--" >> ${METC_HOME}/sql/create_db.log 2>&1
