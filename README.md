# metc-docker
Dockerization of Marketcetera

Approach to creating a Docker Compose for the ORS component of Marketcetera. 
Links to an existing MySQL container, and created another container built on top of Java 6 
to deploy the ORS jars and to initialize the MySQL DB if needed to create the appropriate database/tables/user.

Starts the ORS with the container, exposes the MySQL and ActiveMQ ports
