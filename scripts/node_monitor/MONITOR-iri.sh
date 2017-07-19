#!/bin/bash
# The monitor script for IOTA IRI service, 
# forked from : https://github.com/Akkiaks/Multiple-System-monitoring-in-Shell-script
# make sure all the configs in settings.sh fulfil requirements
# before executing this script.
#
# Copyright (C) 2017 DeviceProof, Inc.
# Written by HuangJyunYu <yillkid@gmail.com>
# All Rights Reserved
#

source ./modules/slack.sh
source ./modules/ssh.sh
source ./modules/nodes.sh
source ./modules/neighbors.sh
source ./modules/iri_service.sh
source ./modules/logger.sh
source ./settings.sh

# Remove tmp files
rm -f /tmp/iri*.tmp

while :
do
    for index_nodes in "${!LIST_NODES[@]}"
    do
        # Check ssh connection
        echo "Check ${LIST_NODES[index_nodes]} SSH connection"
        check_ssh_connect ${LIST_NODES[index_nodes]} status_ssh

        if [[ $status_ssh != 0 ]] ; then
            continue
        fi

	# Check IRI service
        echo "Check IRI service on ${LIST_NODES[index_nodes]} ... "
        check_iri_service ${LIST_NODES[index_nodes]} pid_iri

        # Validate IRI PID with previous
        echo "Validate IRI PID with previous ..."
	validate_pid_chnaged ${LIST_NODES[index_nodes]} $pid_iri

	# Analysis IRI log
        analysis_iri_log ${LIST_NODES[index_nodes]}

        # Check IRI resource
	echo "Check IRI service loading ..."
        check_iri_loading ${LIST_NODES[index_nodes]} $pid_iri

	# Full-nodes
	echo "Check full-nodes status ..."
        analysis_full_node ${LIST_NODES[index_nodes]}

        # Neighbors
        echo "Analysis neighbors ..."
        analysis_neighbors ${LIST_NODES[index_nodes]}
    done

    echo "Waiting $TEST_TIME_INTERVAL sec ..."
    sleep $TEST_TIME_INTERVAL
done
