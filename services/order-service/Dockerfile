# Use official OpenJDK image as a base
## Multi-stage Dockerfile: build with Maven on BellSoft Liberica Alpine JDK 17 and run on the same base

# Builder stage: use BellSoft Liberica Alpine JDK 17 and install Maven via apk
FROM bellsoft/liberica-openjdk-alpine-musl:17 AS builder
WORKDIR /workspace

# Install Maven and unzip (required for some maven plugins)
RUN apk add --no-cache maven bash curl unzip

# Copy project files and download dependencies first to leverage layer caching
COPY pom.xml ./
RUN mvn -B -DskipTests dependency:go-offline || true

# Copy sources and build
COPY src ./src
RUN mvn -B -DskipTests package

# Runtime stage: use the same BellSoft Liberica Alpine image (smaller and compatible with arm64)
FROM bellsoft/liberica-openjdk-alpine-musl:17
WORKDIR /app

# Copy the built jar
COPY --from=builder /workspace/target/*.jar app.jar

# Expose port and run
EXPOSE 8080

#ENTRYPOINT ["java", "-jar", "app.jar"]

# Set working directory inside the container
WORKDIR /app

# Copy the built jar file from your host to /app in container
COPY target/order-service-*.jar app.jar

# Expose the port the service will listen on
EXPOSE 8080

# Run the jar using Java
ENTRYPOINT ["java", "-jar", "app.jar"]
