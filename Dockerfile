FROM openjdk:11
COPY target/sample-spring.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]