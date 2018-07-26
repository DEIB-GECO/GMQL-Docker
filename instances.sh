#!/bin/bash

# instances.sh start/stop n_instances

cmd=${1:-"start"}
n=${2:-3}

echo "Command: $cmd"
echo "# instances: $n"

if [ $cmd = "start" ]
then
    echo "Starting GMQL docker instances"
    for (( i=1; i<=$n; i++ ))
    do
        docker run -d -p 1111$i:80 --name gmql1111$i gmql_docker
    done
fi

if [ $cmd = "stop" ]
then
    echo "Stopping GMQL docker instances"
    for (( i=1; i<=$n; i++ )) 
    do
        docker stop gmql1111$i
        docker rm gmql1111$i
    done
fi