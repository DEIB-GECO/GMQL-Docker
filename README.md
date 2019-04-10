# GMQL-Docker
Dockerizing GMQL

[![Build Status](https://travis-ci.org/DEIB-GECO/GMQL-Docker.svg?branch=master)](https://travis-ci.org/DEIB-GECO/GMQL-Docker)
[![DockerHub](https://images.microbadger.com/badges/version/gecopolimi/gmql.svg)](https://microbadger.com/images/gecopolimi/gmql "Get your own version badge on microbadger.com")

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

run_gmql_docker.sh [-r|--conf-repository <arg>] [-e|--conf-executor <arg>] [-g|--gmql_repository <arg>] [-h|--help] [<port>]
        <port>: port (default: '11110')
        -r,--conf-repository: path to custom repository.xml (no default)
        -e,--conf-executor: path to custom executor.xml (no default)
        -g,--gmql_repository: path to custom repository location (no default)
        -h,--help: Prints help

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
