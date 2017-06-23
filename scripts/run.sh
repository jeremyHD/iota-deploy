#!/bin/bash

if [ "$1" == "" ]; then
    echo "Usage: ./run.sh [the iri version you want to run] [path of config file]"
    exit 1
fi

IRI=iri-$1.jar

set -x

pkill -9 java

# FIXME: move runtime logs to dedicated directory
rm -f nohup.out
rm -f hs_err_pid*.log

nohup java -server \
	-Xmx540m -Xms128m -Xmn1g -Xss512k \
	-Xmn256m \
        -Xincgc \
        -XX:InitiatingHeapOccupancyPercent=0 \
        -XX:MaxMetaspaceSize=256m \
	-XX:ReservedCodeCacheSize=2496k \
	-XX:CodeCacheMinimumFreeSpace=100k \
	-XX:MaxHeapFreeRatio=10 -XX:MinHeapFreeRatio=5 \
        -XX:+UseCompressedOops \
	-Djava.awt.headless=true \
	-jar /home/ubuntu/$IRI \
	--config $2 \
        --remote-limit-api 'removeNeighbors, addNeighbors' --remote > nohup.out &

sleep 2
cat nohup.out
