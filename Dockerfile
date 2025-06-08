FROM gradle:8.6-jdk21-jammy AS builder
WORKDIR /app
COPY --chown=gradle:gradle . .
RUN gradle bootJar --no-daemon

FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8000
ENTRYPOINT ["java", "-jar", "app.jar"]