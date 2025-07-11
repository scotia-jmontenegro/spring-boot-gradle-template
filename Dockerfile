# Build stage
FROM eclipse-temurin:17-jdk as builder
WORKDIR /workspace/app
COPY . .
RUN ./gradlew build

# Runtime stage
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /workspace/app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]