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

## Set the command to run your application
CMD ["java", "-jar", "/app/current-time.jar"]

## Infrastructure Setup and Deployment
Terraform is used to provision and manage the GCP infrastructure. The infrastructure setup includes:

## Google Kubernetes Engine (GKE) Cluster: Where the API is deployed.
NAT Gateway: Manages egress traffic from the cluster.
IAM Roles and Policies: Manage permissions.
VPC Networking and Subnets: Configures networking for secure communication.
Kubernetes Resources: Includes Deployments, Services, and Ingress.

## Terraform Configuration
The Terraform code is located in the infrastructure directory. It defines the following resources:
VPC Network and Subnetwork: For networking setup.
GKE Cluster: For running the Kubernetes workload.
NAT Router and NAT Gateway: For managing outbound traffic.
Kubernetes Deployment and Service: For deploying the API in Kubernetes.
IAM Roles: For granting access permissions.

## GitHub Actions
The CI/CD pipeline is automated using GitHub Actions. The workflow performs the following tasks:
1. Checkout Code: Checks out the repository code.
2. Set Up Terraform: Installs and configures Terraform.
Authenticate with Google Cloud: Sets up authentication for GCP.
Set Up Google Cloud SDK: Installs the Google Cloud SDK.
Terraform Init: Initializes Terraform configuration.
Terraform Plan: Prepares a plan for provisioning infrastructure.
Terraform Apply: Applies the Terraform configuration to deploy the infrastructure.
