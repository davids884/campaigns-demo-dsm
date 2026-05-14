FROM eclipse-temurin:17.0.14_7-jdk-ubi9-minimal
VOLUME /tmp
EXPOSE 5000
COPY *.jar app.jar
ENTRYPOINT ["sh","-c", "java -jar /app.jar"]
