FROM java:6-jre

ADD sql-setup /metc/sql-setup
ADD marketcetera-2.2.1 /metc/marketcetera-2.2.1

EXPOSE 61616

# install mysql-client, emacs, netstat and ps
RUN apt-get update
RUN apt-get install -y mysql-client
RUN apt-get install -y emacs
#RUN apt-get install -y vim
RUN apt-get install -y net-tools
RUN apt-get install -y procps

# create marketcetera user
RUN useradd -d /metc -s /bin/bash marketcetera
RUN chown -R marketcetera /metc

USER marketcetera
WORKDIR /metc/marketcetera-2.2.1

WORKDIR /metc/sql-setup

CMD ./start-wrapper.sh
