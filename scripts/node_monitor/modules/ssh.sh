#!/bin/bash
# SSH service functions
#
# Copyright (C) 2017 DeviceProof, Inc.
# Written by HuangJyunYu <yillkid@gmail.com>
# All Rights Reserved
#

source ./modules/slack.sh

SSH_CONNECT_TIMEOUT=10

function check_ssh_connect() 
{
    status=$(ssh -o BatchMode=yes -o ConnectTimeout=$SSH_CONNECT_TIMEOUT $1 echo -e ok 2>&1)

    if [[ $status == "ok" ]] ; then
        eval $2=0
    else
        echo "SSH connect fail, continue"
        msg_slack_nodeinfo_channel "Error: Can't SSH to $1, try again ..."

        eval $2=1
    fi
}
