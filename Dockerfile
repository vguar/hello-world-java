FROM openjdk:8-jdk-alpine
RUN addgroup -g 1001 java \
&& adduser -G java -D -u 1001 java
EXPOSE 8080
EXPOSE 8081
RUN chmod g=u /etc/passwd
ENTRYPOINT [ "uid_entrypoint" ]
USER 1001
RUN mkdir /home/java/test
RUN chmod 775 /home/java/test
COPY target/hello-world-2.0.jar  /tmp/hello-world-2.0.jar
#CMD  ["java","-jar","/tmp/hello-world-2.0.jar"]
CMD  ["run"]
