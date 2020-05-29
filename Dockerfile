FROM openjdk:8-jdk-alpine
RUN addgroup -g 1001 java \
&& adduser -G java -D -u 1001 java
USER 1001
EXPOSE 8080
EXPOSE 8081
RUN mkdir /home/java/test
RUN chmod 775 /home/java/test
COPY target/hello-world-0.1.0.jar  /tmp/hello-world-0.1.0.jar
COPY dd-java-agent.jar /tmp/dd-java-agent.jar
CMD  ["java","-jar","/tmp/hello-world-0.1.0.jar","-javaagent","/tmp/dd-java-agent.jar"]
