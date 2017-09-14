curl -s http://localhost:14265 \
	-X POST \
	-H 'Content-Type: application/json' \
	-d '{"command": "getNodeInfo"}' | python -m json.tool
