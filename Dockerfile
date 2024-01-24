FROM alpine/git:latest as clone
WORKDIR /app
RUN git clone https://github.com/hanss2006/spring_docker_hello.git

FROM maven:3.9.6-eclipse-temurin-21 AS build
RUN addgroup spring-boot-group && adduser --ingroup spring-boot-group spring-boot
USER spring-boot:spring-boot-group
WORKDIR /app
COPY --from=clone /app/spring_docker_hello .
RUN --mount=type=cache,target=/root/.m2 mvn clean package dependency:copy-dependencies -DincludeScope=runtime

FROM  bellsoft/liberica-openjdk-debian:21
WORKDIR /app
COPY --from=build /app/target/spring_docker_hello-0.0.1-SNAPSHOT.jar /app
EXPOSE 8080
CMD ["java -jar spring_docker_hello-0.0.1-SNAPSHOT"]
