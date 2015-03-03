#!/bin/sh

## 
## Stop Marketcetera MySQL service
##
## Future: If messages are an output of this script, then those messages
##         will have to be localized using resource bundles, not hard-coded.
## 
## Author: klim@marketcetera.com
## Since: 1.5.0
## Version: $Id: stop_mysql.sh 15620 2009-10-26 17:37:27Z klim $
##

check_status()
{
    # mysqladmin ... ping returns 0 if the server is running, 1 if it is not.
    ./bin/mysqladmin --verbose --host=${MYSQL_HOST} --port=${MYSQL_PORT} --user=root --password=${MYSQL_ROOT_PASSWORD} ping > /dev/null 2>&1
}

. "$(dirname $0)/../setEnv.sh"

cd ${METC_HOME}/mysql

counter=0

while [ $counter -lt 20 ]
do
    check_status
    if [ $? -eq 0 ]; then
        # NOTE: If you have changed the root password to MySQL, you 
        #       must update --password='<new password>' below.
        ./bin/mysqladmin --verbose --user=root --password=${MYSQL_ROOT_PASSWORD} shutdown
    else
        break
    fi
    sleep 1
    counter=`expr $counter + 1`
done

if [ $counter -ge 20 ]; then
    echo "Cannot stop MySQL.  Please check the MySQL error log ${MYSQL_HOME}/data/*.err"
    exit 1
fi

