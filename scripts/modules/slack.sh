#!/bin/bash
# Slack sender
#
# Copyright (C) 2017 DeviceProof, Inc.
# Written by HuangJyunYu <yillkid@gmail.com>
# All Rights Reserved
#

source ./settings.sh

function msg_slack_nodeinfo_channel() 
{
    curl -X POST --data-urlencode \
	    "payload={\"channel\": \"#nodeinfo\",
	    \"username\": \"webhookbot\", 
	    \"text\": \"$1\", 
	    \"icon_emoji\": \":ghost:\"}" ${SLACK_URL}
}
