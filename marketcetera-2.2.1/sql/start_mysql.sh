#!/bin/sh

## 
## Start Marketcetera MySQL service
##
## Future: If messages are an output of this script, then those messages
##         will have to be localized using resource bundles, not hard-coded.
## 
## Author: klim@marketcetera.com
## Since: 1.5.0
## Version: $Id: start_mysql.sh 15620 2009-10-26 17:37:27Z klim $
##

check_status()
{
    # mysqladmin ... ping returns 0 if the server is running, 1 if it is not.
    ./bin/mysqladmin --verbose --host=${MYSQL_HOST} --port=${MYSQL_PORT} --user=root --password=${MYSQL_ROOT_PASSWORD} ping > /dev/null 2>&1

    # check the time between start execution of the mysqld_safe wrapper script and the mysqld server process
    if [ $? -eq 1 ]; then
        numofstarts=`ps xaww | grep -v "grep" | grep "./bin/mysqld_safe" | grep -c "defaults-file=${METC_HOME}"`
        if [ $numofstarts -ne 0 ]; then
            sleep 1
            check_status
            return $?
        else
            return 1
        fi
    fi
}

. "$(dirname $0)/../setEnv.sh"

cd ${METC_HOME}/mysql

counter=0

while [ $counter -lt 20 ]
do
    check_status
    if [ $? -eq 1 ]; then
        if [ ! -d ${METC_HOME}/mysql/data/mysql ]; then
            ./scripts/mysql_install_db >> ${METC_HOME}/sql/create_db.log 2>&1
        fi
        ./bin/mysqld_safe --defaults-file=${METC_HOME}/mysql/my.cnf &
    else
        break
    fi
    sleep 1
    counter=`expr $counter + 1`
done

if [ $counter -ge 20 ]; then
    echo "Cannot start MySQL.  Please check the MySQL error logs ${MYSQL_HOME}/data/*.err"
    exit 1
fi
