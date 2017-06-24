#!/bin/bash
# IOTA IRI service analysis module
#   
# Copyright (C) 2017 DeviceProof, Inc.
# Written by HuangJyunYu <yillkid@gmail.com>
# All Rights Reserved
#

source ./modules/slack.sh
source ./settings.sh

RSS_UPPER_BOUND=665600
CPU_UPPER_BOUND=185.5

# Check if IRI PID changed
function validate_pid_chnaged()
{
    # Get old PID log
    old_pid_iri=`ssh $1 "cat /home/ubuntu/LOGS/iri.pid"`

    if [[ $old_pid_iri != $2 ]] ; then
        echo "Error: $1 PID changed !"
        msg_slack_nodeinfo_channel "Error: $1 PID changed !"

        # Syncup PID file
        ssh $1 "cp /var/run/iri.pid /home/ubuntu/LOGS/iri.pid"
    fi
}

# Validate IRI service status, if no PID get, restart the service
function check_iri_service()
{
    # Get PID
    pid_iri=`ssh $1 "pgrep -f $IRI &"`
    
    if [[ $pid_iri == "" ]] ; then
        echo "Restarting IRI on ${LIST_NODES[index_nodes]} ..."
        IFS='@ ' read -r -a domain_name <<< "$1"
        config_name="${domain_name[1]//./_}.config"

        # Restart
        ssh $1 "sh /home/ubuntu/run.sh $VERION_IRI /home/ubuntu/iri_deploy_scripts/configs/$config_name > /dev/null 2>&1 &"
        msg_slack_nodeinfo_channel "Error: $1 
            IRI service is down, try to restart, refer to the LOG/
            nohup.out for detail."
    else
        echo "$1 IRI service still running (PID: $pid_iri) ..."
    fi
}

# Check system loading
function check_iri_loading() 
{
    if [[ $2 == "" ]] ; then
        return 1
    fi

    echo "Check system loading(RSS) ..."
    log_rss=`ssh $1 "ps -p $2 -o rss="`

    if [[ $1 == "ubuntu@node.deviceproof.org" ]] ; then
        if [[ $log_rss > $RSS_UPPER_BOUND ]] ; then
            echo "Error: $1: RSS value up to $log_rss"
            msg_slack_nodeinfo_channel "Error: $1: RSS value up to $log_rss"
        fi
    fi

    echo "Check system loading(CPU) ..."
    log_cpu=`ssh $1 "ps -p $2 -o pcpu="`

    if [[ $1 == "ubuntu@node.deviceproof.org" ]] ; then
        if [[ $log_cpu > $CPU_UPPER_BOUND ]] ; then
            echo "Error: $1: CPU loading up to $log_cpu"
            msg_slack_nodeinfo_channel "Error: $1: CPU loading up to $log_cpu"
        fi
    fi
}
