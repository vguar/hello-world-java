FROM openjdk:8
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget && rm -rf /var/lib/apt/lists/*
EXPOSE 8080
EXPOSE 8081
COPY target/hello-world-0.2.0.jar  /tmp/hello-world-0.2.0.jar
CMD  ["java","-jar","/tmp/hello-world-0.2.0.jar"]

