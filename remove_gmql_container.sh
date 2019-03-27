#!/usr/bin/env bash

port=${1:-11110}

docker container rm gmql_${port}