FROM openjdk:8
ADD target/devops-integration.jar  app.jar
EXPOSE 8081
CMD ["java","-jar","app.jar"]

