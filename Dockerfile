FROM openjdk:8
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget && rm -rf /var/lib/apt/lists/*
EXPOSE 8080
EXPOSE 8081
COPY target/gs-spring-boot-docker-0.1.0.jar  /tmp/gs-spring-boot-docker-0.1.0.jar
CMD  ["java","-Xmx512M","-Xms512M","-jar","/tmp/gs-spring-boot-docker-0.1.0.jar"]

