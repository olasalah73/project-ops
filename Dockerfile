FROM openjdk:8-jdk-alpine
EXPOSE 8080
ARG JAR_FILE=target/*.jar
RUN addgroup -S docker && adduser -S ubuntu -G docker
ADD ${JAR_FILE} /home/ubuntu/app.jar
USER ubuntu
ENTRYPOINT ["java","-jar","/home/ubuntu/app.jar"]
