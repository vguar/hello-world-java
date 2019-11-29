FROM openjdk:8-jdk-alpine
#RUN addgroup -g 1001 java \
#&& adduser -G java -D -u 1001 java
COPY run /run
COPY uid_entrypoint /uid_entrypoint
EXPOSE 8080
EXPOSE 8081
COPY target/hello-world-2.0.jar  /tmp/hello-world-2.0.jar
#CMD  ["java","-jar","/tmp/hello-world-2.0.jar"]

### Setup user for build execution and application runtime
ENV APP_ROOT=/
ENV PATH=${APP_ROOT}/bin:${PATH}
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

### Containers should NOT run as root as a good practice
USER 1001
WORKDIR ${APP_ROOT}

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
ENTRYPOINT [ "uid_entrypoint" ]
VOLUME ${APP_ROOT}/logs ${APP_ROOT}/data
CMD run
