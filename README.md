# Cloud Engineering Take-Home Assignment

Welcome to the Cloud Engineering Take-Home Assignment! This project demonstrates deploying a simple API to Google Cloud Platform (GCP) using Kubernetes (GKE) with Infrastructure as Code (IaC) through Terraform. GitHub Actions is used for Continuous Deployment (CD). Below, you’ll find detailed instructions on how to run, test, and understand the setup.

## Deployed API Endpoint

The API is accessible at:

**[API Endpoint](http://34.38.144.95/)**

This endpoint returns the current time in JSON format when you send a GET request.

## Swagger Documentation

For interactive API documentation, visit:

**[Swagger UI](http://34.38.144.95/swagger-ui/index.html#/time-controller/getCurrentTime)**

Swagger UI provides a way to explore the API endpoints and see the available operations.

## Sample API Request

To fetch the current time with a specific timezone, use the following sample URL:

**[Sample Request](http://34.38.144.95/api/v1/time?timezone=Europe/London)**

You can replace `Europe/London` with any valid timezone to get the current time for that timezone.

## Dockerization

The API has been containerized using Docker. Here’s how the Docker setup is organized:

### Dockerfile

The `Dockerfile` sets up the environment for the API. It uses an OpenJDK runtime as the base image, copies the packaged JAR file into the container, exposes port `8080`, and defines the command to run the API.

```Dockerfile
# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged jar file into the container
COPY target/current-time-0.0.1-SNAPSHOT.jar /app/current-time.jar

# Expose the port that your application will run on
EXPOSE 8080

# Set the command to run your application
CMD ["java", "-jar", "/app/current-time.jar"]

```Dockerfile
# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged jar file into the container
COPY target/current-time-0.0.1-SNAPSHOT.jar /app/current-time.jar

# Expose the port that your application will run on
EXPOSE 8080

# Set the command to run your application
CMD ["java", "-jar", "/app/current-time.jar"]

