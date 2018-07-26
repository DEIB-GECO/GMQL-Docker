#!/bin/bash

cli_location="./GMQL/GMQL-Cli"
#cli_jar=""

function mvn-there() {
  DIR="$1"
  shift
  (cd $DIR; mvn "$@")
}

mvn-there $cli_location install