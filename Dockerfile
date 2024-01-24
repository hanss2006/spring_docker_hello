FROM alpine/git:latest
WORKDIR /project
RUN git clone https://github.com/hanss2006/spring_docker_hello.git

FROM openjdk:21
COPY --from=0 /project /opt/app/
WORKDIR /opt/app/backend-service
RUN chmod +x ./mvnw
ENV SERVER_PORT=8080
CMD ["./mvnw", "spring-boot:run"]
