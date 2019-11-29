FROM openjdk:8-jdk-alpine
#RUN addgroup -g 1001 java \
#&& adduser -G java -D -u 1001 java



### Setup user for build execution and application runtime
RUN mkdir -p /opt/app-root
ENV APP_ROOT=/opt/app-root
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

### Containers should NOT run as root as a good practice
USER 1001
WORKDIR ${APP_ROOT}
COPY target/hello-world-2.0.jar  ${APP_ROOT}/hello-world-2.0.jar


### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
ENTRYPOINT [ "uid_entrypoint" ]
VOLUME ${APP_ROOT}/logs ${APP_ROOT}/data

EXPOSE 8080
EXPOSE 8081

CMD  ["java","-jar","${APP_ROOT}/hello-world-2.0.jar"]
