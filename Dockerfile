# Use a Maven + JDK base image to build the project
FROM maven:3.9.3-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies first (cache)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy project source
COPY src ./src

# Build the Spring Boot jar
RUN mvn clean package -DskipTests

# Use JDK base image for running the app
FROM eclipse-temurin:17-jdk

# Copy the jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run the Spring Boot app
ENTRYPOINT ["java","-jar","/app.jar"]

