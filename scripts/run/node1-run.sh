#!/bin/bash

if [ "$1" == "" ]; then
    echo "Usage: ./run.sh [the iri version you want to run]"
    exit 1
fi

IRI=iri-$1.jar

set -x

pkill -9 java

nohup java \
        -Xmx512m -Xms256m -Xmn2g -Xss512k \
        -XX:+UseParallelGC -server \
	-jar $IRI \
	--config iri_depoly_scripts/configs/node1-config.ini \
	--remote-limit-api 'removeNeighbors, addNeighbors' --remote &
sleep 2
cat nohup.out
