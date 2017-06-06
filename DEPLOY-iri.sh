#!/bin/bash

if [ "$s1" == "" ]; then
    echo "usage: ./DEPLOY-iri.sh [the iri version you want to deploy]"
fi

exit 0

IRI=iri-$1.jar 

TMP=/tmp/remote.out

for i in {2..9}
do
    echo "Copying $IRI to node$i ..."
    scp $IRI ubuntu@node$i.puyuma.org:~
    echo "Restarting IRI on node$i ..."
    ssh ubuntu@node$i.puyuma.org "sh /home/ubuntu/run.sh &"
    sleep 1
    rm -f $TMP
    ssh ubuntu@node$i.puyuma.org "ps aux" > $TMP
    if grep $IRI $TMP > /dev/null; then
        echo "node$i is ready."
    fi
done
