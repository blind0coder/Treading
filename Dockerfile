FROM eclipse-temurin:17-jdk AS build
WORKDIR /app

# Copy project files
COPY .mvn/ mvnw pom.xml src/ ./

# Convert to Unix line endings & make wrapper executable
RUN apt-get update && apt-get install -y dos2unix \
    && dos2unix mvnw \
    && chmod +x mvnw

# Execute Maven build
RUN ./mvnw clean package -DskipTests

...
