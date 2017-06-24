#!/bin/bash
# IOTA IRI node analysis
#
# Copyright (C) 2017 DeviceProof, Inc.
# Written by HuangJyunYu <yillkid@gmail.com>
# All Rights Reserved
#

source ./modules/slack.sh

MILESTONE_START_INDEX=62000

function analysis_full_node() 
{
    log_full_node=`ssh ${LIST_NODES[index_nodes]} "./node_info.sh 2> /dev/null"`

    latestMilestoneIndex=$(echo $log_full_node | jq '.latestMilestoneIndex')
    latestSolidSubtangleMilestoneIndex=$(echo $log_full_node | jq '.latestSolidSubtangleMilestoneIndex')

    if [[ $latestMilestoneIndex == $latestSolidSubtangleMilestoneIndex && $latestSolidSubtangleMilestoneIndex > $MILESTONE_START_INDEX  ]] ; then
        echo "Info: $1 : Full sync!"
	msg_slack_nodeinfo_channel "Info: $1 : Full sync!"
    fi
}
