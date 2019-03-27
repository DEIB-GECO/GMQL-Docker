# JVM docker image
FROM openjdk:8-jre

ARG gmql_dir=./gmql-web-2.2-SNAPSHOT/
ARG spark_dir=./spark-2.2.0-bin-hadoop2.7

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
# ADD ./gmql-web-1.0-SNAPSHOT.zip /app
ADD ${gmql_dir} /app/${gmql_dir}
ADD ${spark_dir} /app/${spark_dir}

# Make port 80 available to the world outside this container
EXPOSE 8000

ENV GMQL_DIRECTORY=$gmql_dir

CMD ["sh", "-c", "/app/${GMQL_DIRECTORY}/bin/gmql-web", "-Dhttp.port=8000"]