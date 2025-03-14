# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the WAR file to the container
COPY target/COMP367WebApp.war /app/COMP367WebApp.war

# Expose the application port
EXPOSE 9090

# Run the WAR file using Java
CMD ["java", "-jar", "COMP367WebApp.war"]
