#!/bin/bash
# IOTA IRI log file analysis
#   
# Copyright (C) 2017 DeviceProof, Inc.
# Written by HuangJyunYu <yillkid@gmail.com>
# All Rights Reserved
#

source ./modules/slack.sh

# TODO: Write to a script for sourcing
LIST_ERROR_MSG_GREP=(error
terminate\ called\ without\ an\ active\ exception)

# Error message grep
function analysis_iri_log() 
{
    for index_err_msg in "${!LIST_ERROR_MSG_GREP[@]}"
    do
        echo "Check segment (${LIST_ERROR_MSG_GREP[index_err_msg]}) $1:in nohup.out ..."
        log_nohup=`ssh $1 "grep -ir \"${LIST_ERROR_MSG_GREP[index_err_msg]}\" ./nohup.out"`
        if [[ $log_nohup != "" ]] ; then
            echo "Error: $1:nohup.out got error : "$log_nohup
            msg_slack_nodeinfo_channel "Error: $1:nohup.out got error : $log_nohup"
        fi
    done

    # OpenJDK error check
    echo "Check OpenJDK log ..."
    log_jdk_error=`ssh $1 "ls hs_err_* 2> /dev/null | wc -l"`
    if [[ $log_jdk_error != 0 ]] ; then
        echo "Error: $1:OpenJDK error check file hs_err_* please: "
        msg_slack_nodeinfo_channel "Error: $1:OpenJDK error check file hs_err_* please: "
    fi
}
