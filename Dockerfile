# Step 1: Build stage with Java 21
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app
COPY . /app

RUN chmod +x ./mvnw
RUN ./mvnw clean package -DskipTests

# Step 2: Runtime stage
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
