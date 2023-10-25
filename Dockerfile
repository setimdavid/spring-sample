FROM alpine as build

ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

# Install Java.
RUN apk --update --no-cache add openjdk11 curl

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
 && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
 && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
 && rm -f /tmp/apache-maven.tar.gz \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

CMD ["mvn", "--version"]

RUN mvn -DskipTests=true clean install

FROM eclipse-temurin:17-jre-jammy
WORKDIR /otp
EXPOSE 8080

CMD ["ls", "-lrt"]

COPY /otp/simple-spring.jar /opt/app.jar

ENTRYPOINT ["java", "-jar", "/opt/app.jar" ]