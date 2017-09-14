#!/bin/bash
# Run this script before you begin to deploy IOTA nodes with a snapshot

# List of full-nodes
FILE_NODES_CONNECTION="/home/ubuntu/iota-deploy/configs/list_nodes.config"
LIST_NODES=`cat $FILE_NODES_CONNECTION`
LIST_NODES=(${LIST_NODES//,/ })

# Preparing to snapshot

for i in "${!LIST_NODES[@]}"
do
    echo "Stopping IRI on ${LIST_NODES[i]} ..."
    IFS='@ ' read -r -a domain_name <<< "${LIST_NODES[i]}"
    ssh ${LIST_NODES[i]} "pkill -9 java"
    echo "Moving DB for snapshot ..."
    ssh ${LIST_NODES[i]} "mv mainnet.log OLD/ ; mv mainnetdb OLD/"
    sleep 1
done
