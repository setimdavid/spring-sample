FROM eclipse-temurin:11-jdk-jammy as builder
WORKDIR /usr/src/app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY ./src ./src
RUN ./mvnw -DskipTests=true clean install

FROM eclipse-temurin:17-jre-jammy
WORKDIR /usr/src/app
EXPOSE 8080
COPY --from=builder /usr/src/app/target/*.jar /usr/src/app/*.jar
ENTRYPOINT ["java", "-jar", "/usr/src/app/*.jar" ]