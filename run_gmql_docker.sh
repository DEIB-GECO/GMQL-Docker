#!/usr/bin/env bash

port=${1:-11110}

docker run -d -p ${port}:8000 --name gmql_${port} gmql
