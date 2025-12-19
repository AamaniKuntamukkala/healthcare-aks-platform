# ---------- Builder ----------
FROM bellsoft/liberica-openjdk-alpine-musl:17 AS builder
WORKDIR /workspace
 
RUN apk add --no-cache maven bash curl unzip
 
COPY pom.xml .
RUN mvn -B dependency:go-offline || true
 
COPY src src
RUN mvn -B -DskipTests package
 
# ---------- Runtime ----------
FROM bellsoft/liberica-openjdk-alpine-musl:17
WORKDIR /app
 
COPY --from=builder /workspace/target/*.jar app.jar
 
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
