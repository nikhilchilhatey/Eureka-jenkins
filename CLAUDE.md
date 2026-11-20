# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Eureka** is a Netflix Eureka Server implementation using Spring Boot 4.0.0 and Spring Cloud 2025.1.0 (Java 24). It acts as a service registry for microservice discovery in a distributed system. The application runs on port 8761 (standard Eureka dashboard port).

## Build & Run Commands

```bash
# Build and run tests
./mvnw clean install

# Package only (skip tests)
./mvnw clean package -DskipTests

# Run locally
./mvnw spring-boot:run

# Run all tests
./mvnw test

# Run a single test class
./mvnw test -Dtest=EurekaApplicationTests
```

## Docker & Kubernetes

```bash
# Build Docker image (output JAR is eks-eureka.jar)
docker build -t eks-eureka .

# Apply Kubernetes manifests
kubectl apply -f k8s.yaml
```

The Dockerfile uses `eclipse-temurin:24-jre` (not `openjdk:24`). The k8s deployment targets AWS ECR (`611491981233.dkr.ecr.ap-south-1.amazonaws.com/springboot-eks:latest`) with 3 replicas and a LoadBalancer service.

## Architecture

This is a minimal single-module Spring Boot application. There is essentially one source file:

- **`EurekaApplication.java`** — annotated with `@SpringBootApplication` + `@EnableEurekaServer`; no other components exist.

The `application.properties` configures it as a standalone server (not a Eureka client itself):

```properties
spring.application.name=EurekaServer
server.port=8761
eureka.client.fetchRegistry=false
eureka.client.register-with-Eureka=false
eureka.instance.hostname=localhost
```

Note: The Dockerfile exposes port 8080, while `application.properties` uses 8761 — be aware of this mismatch when deploying.