#!/bin/bash

if [ "$1" == "" ]; then
    echo "Usage: ./run.sh [the iri version you want to run]"
    exit 1
fi

IRI=iri-$1.jar

set -x

pkill -9 java

# FIXME: move runtime logs to dedicated directory
rm -f nohup.out
rm -f hs_err_pid*.log

# -XX:+UseParallelGC
nohup java -server \
        -Xmx580m -Xms128m -Xmn1g -Xss512k \
        -XX:+UseParNewGC \
        -XX:MaxMetaspaceSize=256m \
        -XX:+UseCompressedOops \
        -jar /home/ubuntu/$IRI \
        --config iri_deploy_scripts/configs/node2-config.ini \
        --remote-limit-api 'removeNeighbors, addNeighbors' --remote &

sleep 2
cat nohup.out
