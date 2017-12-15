FROM openjdk:8-alpine
ENV LANG fr_FR.UTF-8
RUN apk add --update ttf-dejavu ttf-ubuntu-font-family && rm -rf /var/cache/apk/*
EXPOSE 8081
RUN mkdir /config
VOLUME /tmp
VOLUME /config
COPY target/com.*.jar com.app.jar
ENTRYPOINT ["java","-jar","/com.app.jar"]
