# Step 1: Build stage
FROM eclipse-temurin:21-jdk-alpine AS build

# Install bash (required for ./mvnw on Alpine)
RUN apk add --no-cache bash

WORKDIR /app
COPY . .

# Ensure wrapper script is executable
RUN chmod +x ./mvnw

# Build the app
RUN ./mvnw clean package -DskipTests

# Step 2: Runtime stage
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy the jar file from the build stage (update with your exact JAR name)
COPY --from=build /app/target/email-writer-sb-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
