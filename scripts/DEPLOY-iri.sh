#!/bin/bash

if [ "$1" == "" ]; then
    echo "Usage: ./DEPLOY-iri.sh [the iri version you want to deploy]"
    exit 1
fi

IRI=iri-$1.jar 

TMP=/tmp/remote.out

# validate thee iri file
echo "Validate iri-$1.jar" 
./VALIDATE-iri.sh iri-$1.jar

for i in {2..9}
do
    echo "Copying $IRI to node$i ..."
    scp $IRI ubuntu@node$i.puyuma.org:~
    echo "Restarting IRI on node$i ..."
    ssh ubuntu@node$i.puyuma.org "sh /home/ubuntu/run.sh \"$1\" > /dev/null 2>&1 &"
    sleep 1
    rm -f $TMP
    ssh ubuntu@node$i.puyuma.org "ps aux" > $TMP
    if grep $IRI $TMP > /dev/null; then
        echo "node$i is ready."
    fi
done
