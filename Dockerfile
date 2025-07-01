
# Stage 1 — build the JAR using Maven wrapper
FROM maven:3-eclipse-temurin-17 AS build
WORKDIR /app

# Copy only the files needed for build
COPY .mvn/ mvnw pom.xml ./
RUN chmod +x mvnw

COPY src/ src/
RUN ./mvnw clean package -DskipTests

# Stage 2 — build the runtime image
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

# Copy the built JAR from the first stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
