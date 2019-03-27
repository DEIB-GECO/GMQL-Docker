# GMQL-Docker
Dockerizing GMQL

Set of scripts to build, run and deploy the Docker image of GMQL

## Requirements
- Docker
- Unix-like operating system
- This repository cloned: `git clone https://github.com/DEIB-GECO/GMQL-Docker.git`

## Installing the docker image
```
docker pull gecopolimi/gmql
```

## Running the docker image
```
cd GMQL-Docker
run_gmql_docker.sh <listening_port>
```
where `<listening_port>` is the port on the local machine where the GMQL service is hosted

## Stopping the docker image
```
stop_gmql_docker.sh <listening_port>
```

## Removing the GMQL docker container
```
remove_gmql_container.sh <listening_port>
```
