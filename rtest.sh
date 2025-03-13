#!/bin/bash

today=$(date +%Y%m%d-%H%M)

echo "{\"id\": 1, \"data\": \"example data ${today}\"}" > data1.json
echo "{\"id\": 2, \"data\": \"example shared data ${today}\"}" > datashared1.json


curl -X POST "http://127.0.0.1:8900/create" -H "Content-Type: application/json" -d @./data1.json
curl -X POST "http://127.0.0.1:8900/createshared" -H "Content-Type: application/json" -d @./datashared1.json
echo ""
curl -X GET "http://127.0.0.1:8900/read/1"

echo ""
curl -X GET "http://127.0.0.1:8900/readshared/2"
