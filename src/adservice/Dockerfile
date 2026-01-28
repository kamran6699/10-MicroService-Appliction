# Production Dockerfile (recreated) - adservice (Java / gRPC)

FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app

COPY ["build.gradle", "gradlew", "./"]
COPY gradle gradle
RUN chmod +x gradlew && ./gradlew downloadRepos

COPY . .
RUN chmod +x gradlew && ./gradlew installDist

FROM eclipse-temurin:21-jre-alpine
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app .

EXPOSE 9555
USER 1000
ENTRYPOINT ["/app/build/install/hipstershop/bin/AdService"]

