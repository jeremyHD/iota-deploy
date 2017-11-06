#!/bin/bash
if [ "$1" != "add" ] && [ "$1" != "remove" ]
then
        echo "Usage: ./set_neighbors.sh [add/remove] [uris]..."
        exit 1
fi
CMD='"'$2'"'
for i in ${@:3}
do
        CMD+=', "'
        CMD+=$i
        CMD+='"'
done
#CMD=`echo $CMD|sed 's/[\]//g'`
echo $CMD
curl http://localhost:14265 \
        -X POST \
        -H 'Content-Type: application/json' \
	-H 'X-IOTA-API-VERSION: 1.4.1' \
        -d "{'command': '$1Neighbors', 'uris': [$CMD]}" | python -m json.tool
