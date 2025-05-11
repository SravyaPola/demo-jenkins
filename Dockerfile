    # Use a Maven image to build the application
FROM maven:3.8.7-eclipse-temurin-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download dependencies (layered to optimize build cache)
COPY pom.xml .

# Download the dependencies
RUN mvn dependency:go-offline -B

# Copy the entire project source code
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use an OpenJDK image to run the application
FROM openjdk:17-jdk


# Set the working directory inside the container
WORKDIR /app

# Copy the packaged jar file from the build stage
COPY --from=build /app/target/myapp-0.0.1-SNAPSHOT.jar  /app/myapp-0.0.1-SNAPSHOT.jar

# Expose the application port
EXPOSE 8081

# Run the application
CMD ["java", "-jar", "myapp-0.0.1-SNAPSHOT.jar"]

# To bind the log files to app.log -- inside container
# CMD java -jar /app/myapp-0.0.1-SNAPSHOT.jar > app.log 2>&1

# To bind the logs in the host, so that even if container stops we can still see the logs in host -- inside host
# RUN mkdir /logs
# Run the application
# CMD java -jar /app/myapp-0.0.1-SNAPSHOT.jar > /logs/app.log 2>&1
