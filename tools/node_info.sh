curl -s http://localhost:14265 \
	-X POST \
	-H 'Content-Type: application/json' \
	-H 'X-IOTA-API-VERSION: 1.4.1' \
	-d '{"command": "getNodeInfo"}' | python -m json.tool
