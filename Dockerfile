FROM eclipse-temurin:21-jdk
EXPOSE 8081
COPY target/pipeline-test.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]