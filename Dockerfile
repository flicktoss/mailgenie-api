# Step 1: Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app
COPY . /app

# Build the project and skip tests
RUN ./mvnw clean package -DskipTests

# Step 2: Runtime stage
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
