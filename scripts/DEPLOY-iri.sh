#!/bin/bash

if [ "$1" == "" ]; then
    echo "Usage: ./DEPLOY-iri.sh [the iri version you want to deploy]"
    exit 1
fi

IRI=iri-$1.jar 
TMP=/tmp/remote.out

# List of full-nodes
FILE_NODES_CONNECTION="/home/ubuntu/iota-deploy/configs/list_nodes.config"
LIST_NODES=`cat $FILE_NODES_CONNECTION`
LIST_NODES=(${LIST_NODES//,/ })

# validate thee iri file
echo "Validate iri-$1.jar" 
./VALIDATE-iri.sh iri-$1.jar

for i in "${!LIST_NODES[@]}"
do
    echo "Copying $IRI to ${LIST_NODES[i]} ..."
    scp $IRI ${LIST_NODES[i]}:~
    echo "Restarting IRI on ${LIST_NODES[i]} ..."
    IFS='@ ' read -r -a domain_name <<< "${LIST_NODES[i]}"
    config_name="${domain_name[1]//./_}.config"
    ssh ${LIST_NODES[i]} "sh /home/ubuntu/run.sh $1 /home/ubuntu/iota-deploy/configs/$config_name> /dev/null 2>&1 &"
    sleep 1
    rm -f $TMP
    ssh ${LIST_NODES[i]} "ps aux" > $TMP
    if grep $IRI $TMP > /dev/null; then
        echo "${LIST_NODES[i]} is ready."
    fi
done
