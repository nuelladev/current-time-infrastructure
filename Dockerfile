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
