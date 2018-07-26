#!/bin/bash

# instances.sh start/stop n_instances

cmd=${1:-"start"}
n=${2:-3}

starting_port=${3:-11110}

echo "Command: $cmd"
echo "# instances: $n"
echo "Starting port: $starting_port"

if [ $cmd = "start" ]
then
    echo "Starting GMQL docker instances"
    for (( i=0; i<$n; i++ ))
    do
        cur_port=$(( $starting_port + i ))
        docker run -d -p $cur_port:80 --name gmq$cur_port gmql_docker
    done
fi

if [ $cmd = "stop" ]
then
    echo "Stopping GMQL docker instances"
    for (( i=0; i<$n; i++ ))
    do
        cur_port=$(( $starting_port + i ))
        docker stop gmq$cur_port
        docker rm gmq$cur_port
    done
fi