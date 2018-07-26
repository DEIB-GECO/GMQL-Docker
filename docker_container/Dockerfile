# JVM docker image
FROM openjdk:8-jre

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD ./gmql-web-1.0-SNAPSHOT.zip /app

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME GMQL

# Install 
RUN unzip /app/gmql-web-1.0-SNAPSHOT.zip
RUN rm /app/gmql-web-1.0-SNAPSHOT.zip
RUN ls gmql-web-1.0-SNAPSHOT/
CMD ["gmql-web-1.0-SNAPSHOT/bin/gmql-web", "-Dhttp.port=80"]