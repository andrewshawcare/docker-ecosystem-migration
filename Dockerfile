FROM java:openjdk-8u72-jdk

ENV flyway_version 4.0

ADD https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${flyway_version}/flyway-commandline-${flyway_version}-linux-x64.tar.gz /flyway.tar.gz
RUN tar -zx -f /flyway.tar.gz && rm /flyway.tar.gz
ENV PATH ${PATH}:/flyway-${flyway_version}

WORKDIR /flyway-${flyway_version}

COPY ./conf conf
COPY ./sql sql

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
