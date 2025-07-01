

# Stage 1 — build: use Maven image to compile and package
FROM maven:3-eclipse-temurin-17 AS builder
WORKDIR /app

# 1.a Copy POM only, then download dependencies
COPY pom.xml ./
RUN mvn dependency:go-offline

# 1.b Copy source files and build JAR
COPY src/ src/
RUN mvn clean package -DskipTests

# Stage 2 — runtime: use a sleek JRE base
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

