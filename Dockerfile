FROM java:6-jre
FROM mysql:latest

ADD sql-setup /metc

#RUN mysql < /metc/create_server_schema.sql
#RUN mysql < /metc/101_create_admin_user.sql
