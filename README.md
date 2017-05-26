# metc-docker
Dockerization of Marketcetera

Note: this is totally unfinished, and arguably a horrible approach.
One should use [docker-compose](https://docs.docker.com/compose/) instead, and have everything in separate containers.

Approach to creating a Docker Compose for the ORS component of Marketcetera. 
Links to an existing MySQL container, and created another container built on top of Java 6 
to deploy the ORS jars and to initialize the MySQL DB if needed to create the appropriate database/tables/user.

Starts the ORS with the container, exposes the MySQL and ActiveMQ ports.

Note that this is a `suboptimal Docker implementation`, it was done only as a `starter` project to learn more about Docker.
the right way would be to create a `multi-container` setup via [docker-compose](https://docs.docker.com/compose/), have a `separate container` for `database` and `code`, and have the database be `volume-mounted`.
