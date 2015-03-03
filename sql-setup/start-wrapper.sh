#!/bin/bash

echo "before msyql command mysql_addr is: $MYSQL_PORT_3306_TCP_ADDR"

result=`mysql -h $MYSQL_PORT_3306_TCP_ADDR -u root -proot -e  "show databases"`
if [[ "$result" == *marketcetera* ]]
then
	echo "marketcetera user already exists, not doing anything"
else 	
	echo "init the database [$MYSQL_PORT_3306_TCP_ADDR]"
	mysql -h $MYSQL_PORT_3306_TCP_ADDR -u root -proot -e "create database if not exists marketcetera"
	mysql -h $MYSQL_PORT_3306_TCP_ADDR -u root -proot < /metc/sql-setup/create_db.sql
	mysql -h $MYSQL_PORT_3306_TCP_ADDR -u root -proot marketcetera < /metc/sql-setup/create_server_schema.sql
	mysql -h $MYSQL_PORT_3306_TCP_ADDR -u root -proot marketcetera < /metc/sql-setup/101_create_admin_user.sql
fi
echo "after mysql command"

# modify the properties file to substitute the right IP for DB
sed -i s/'metc.jdbc.url=.*'/"metc.jdbc.url=jdbc:mysql:\/\/$MYSQL_PORT_3306_TCP_ADDR:3306\/marketcetera?logSlowQueries=true"/ /metc/marketcetera-2.2.1/ors/conf/user.properties

echo "updated file /metc/marketcetera-2.2.1/ors/conf/user.properties"
grep jdbc /metc/marketcetera-2.2.1/ors/conf/user.properties

cd /metc/marketcetera-2.2.1/ors
bin/ors.sh

