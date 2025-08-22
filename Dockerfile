# Stage 1: Build the application
FROM maven:3.9.3-eclipse-temurin-17 AS build

WORKDIR /app

# Copy Maven files and source code
COPY devopsdemo/pom.xml .
COPY devopsdemo/src ./src

# Build the Spring Boot app
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Copy the jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]


