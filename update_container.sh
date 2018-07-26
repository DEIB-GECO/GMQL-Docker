#!/bin/bash

BASEDIR=$(dirname "$0")

module=$1

do_gmql=false
do_web=false

if [ $module == "all" ]; then
    do_gmql=true
    do_web=true
elif [ $module == "gmql" ]; then
    do_gmql=true
elif [ $module == "web" ]; then
    do_web=true
fi


if $do_gmql ; then
    gmql_project_location="$BASEDIR/GMQL/"
    cli_jar="$BASEDIR/GMQL/GMQL-Cli/target/GMQL-Cli-1.0-SNAPSHOT-jar-with-dependencies.jar"

    # remove GMQL artifacts from maven
    echo removing it.polimi.genomics Maven Cache
    rm -r ~/.m2/repository/it/polimi/genomics/

    # update the GMQL artifacts
    echo updating GMQL Maven artifacts
    cd $gmql_project_location
    mvn -T 10 -q install -DskipTests
    cd $BASEDIR
fi

if $do_web ; then
    web_project_location="$BASEDIR/GMQL-WEB/"

    # remove GMQL artifacts from ivy2
    echo removing it.polimi.genomics Sbt Cache
    rm -r ~/.ivy2/cache/it.polimi.genomics/

    # update the WEB interface
    echo updating GMQL-WEB artifacts
    cd $web_project_location
    sbt dist
    cd $BASEDIR
fi

