#!/usr/bin/env bash

port=${1:-11110}

docker container stop gmql_${port}

