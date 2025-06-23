
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app

COPY mvnw .mvn/ pom.xml ./
COPY src src

RUN chmod +x mvnw && ./mvnw clean package -DskipTests


FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
EXPOSE 8080
