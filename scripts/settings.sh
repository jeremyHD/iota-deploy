#!/bin/bash

# Time interval for one testing period
TEST_TIME_INTERVAL=300

# IRI version
VERION_IRI=1.2.1
IRI=iri-$VERION_IRI.jar

# The file of all nodes ssh connection command
FILE_NODES_CONNECTION="../configs/list_nodes.config"

# List of all nodes for testing
LIST_NODES=`cat $FILE_NODES_CONNECTION`
LIST_NODES=(${LIST_NODES//,/ })

# Slack message notify
SLACK_URL=""
