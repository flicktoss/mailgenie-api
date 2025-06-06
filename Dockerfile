# Step 1: Build stage with Java 24
FROM eclipse-temurin:24-jdk AS build

WORKDIR /app
COPY . /app

# Make mvnw executable
RUN chmod +x ./mvnw

# Build your Spring Boot app
RUN ./mvnw clean package -DskipTests

# Step 2: Runtime stage with Java 24
FROM eclipse-temurin:24-jdk

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
