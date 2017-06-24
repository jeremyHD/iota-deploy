#!/bin/bash
# IOTA IRI neighbors analysis
#
# Copyright (C) 2017 DeviceProof, Inc.
# Written by HuangJyunYu <yillkid@gmail.com>
# All Rights Reserved
#

source ./modules/slack.sh

NEIGHBOR_STATUS_TMP_FILE="/tmp/iri_nb_status.tmp"

function set_0tx_count()
{
    if [ -f "$NEIGHBOR_STATUS_TMP_FILE" ]; then
        # Read file line by line
	exec < $NEIGHBOR_STATUS_TMP_FILE
	flag_found=0

	while read line
	do
	    if [[ $line == *$1,${node_address//\"/}* ]] ; then
		flag_found=1
	        arr_line=(${line//,/ })

		if [[ $2 == 0 ]]; then
		    count_tx=0
		else
	            count_tx=${arr_line[2]}
	            count_tx=$(( count_tx + $2))
		fi

	        final=$1,${node_address//\"/},$count_tx

	        sed -i "s/$line/$final/g" $NEIGHBOR_STATUS_TMP_FILE

		# FIXME: Alert 0 transaction with slack message every hours (still very rough of time calculate)
                counts_of_hours=$((3600/$TEST_TIME_INTERVAL))
	        if [[ $((count_tx%counts_of_hours)) -eq 0 ]] ; then
		    msg_slack_nodeinfo_channel "Error: Neighbor: $1:${node_address//\"/} 0 transaction over $((count_tx/counts_of_hours)) hours"
	        fi
	    fi
	done

	if [[ $flag_found == 0 ]] ; then
	    echo $1,${node_address//\"/},1 >> $NEIGHBOR_STATUS_TMP_FILE
	fi

    else
        `touch $NEIGHBOR_STATUS_TMP_FILE`
    fi
}

function analysis_neighbors() 
{
    log_neighbors=`ssh $1 "./neighbor_info.sh 2> /dev/null"`

    neighbors=$(echo $log_neighbors | jq '.neighbors')
    index=0
    node=$(echo $log_neighbors | jq '.neighbors['$index']')

    while true
    do
	node_address=$(echo $log_neighbors | jq '.neighbors['$index'].address')

	echo "Checking neighbor ... $node_address"

	if [[ $node_address == "null" || $node_address == "" ]]; then
            echo "Finish to analysis neighbors."
	    break
	fi

	node_numberOfAllTransactions=$(echo $log_neighbors | jq '.neighbors['$index'].numberOfAllTransactions')
	node_numberOfInvalidTransactions=$(echo $log_neighbors | jq '.neighbors['$index'].numberOfInvalidTransactions')
	node_numberOfNewTransactions=$(echo $log_neighbors | jq '.neighbors['$index'].numberOfNewTransactions')
	node_numberOfRandomTransactionRequests=$(echo $log_neighbors | jq '.neighbors['$index'].numberOfRandomTransactionRequests')
	node_numberOfSentTransactions=$(echo $log_neighbors | jq '.neighbors['$index'].numberOfSentTransactions')

	# Dead neighbor
        if [[ $node_numberOfAllTransactions == "0" && $node_numberOfInvalidTransactions == "0" && 
		$node_numberOfNewTransactions == "0" && $node_numberOfRandomTransactionRequests == "0" && 
		$node_numberOfSentTransactions == "0" ]] ; then

	        msg_slack_nodeinfo_channel "Error: Neighbor: $1:${node_address//\"/} dead node"
        fi

	# 0 tx neighbor
        if [[ $node_numberOfAllTransactions == "0" && 
		$node_numberOfInvalidTransactions == "0" && 
		$node_numberOfNewTransactions == "0" && 
		$node_numberOfRandomTransactionRequests == "0" ]] ; then

		# Set 0 tx count
                set_0tx_count $1 1
        fi

        index=$(( index + 1))
    done
}
