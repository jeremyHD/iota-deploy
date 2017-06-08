#!/bin/sh

IRI_VER=1.1.4.3

set -x

pkill -9 java

# FIXME: move runtime logs to dedicated directory
rm -f nohup.out
rm -f hs_err_pid*.log

nohup java -server \
        -Xmx580m -Xms128m -Xmn1g -Xss512k \
	-Xincgc \
	-XX:InitiatingHeapOccupancyPercent=0 \
	-XX:MaxMetaspaceSize=256m \
	-XX:+UseCompressedOops \
	-jar /home/ubuntu/iri-$IRI_VER.jar \
	--config iri_deploy_scripts/configs/devorg-config.ini \
	--remote-limit-api 'removeNeighbors, addNeighbors' --remote &
sleep 2
cat /home/ubuntu/nohup.out
