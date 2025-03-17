#!/bin/bash

today=$(date +%Y%m%d-%H%M)

#echo "{\"id\": 1, \"data\": \"example data ${today}\"}" > data1.json
#echo "{\"id\": 2, \"data\": \"example shared data ${today}\"}" > datashared1.json


#curl -X POST "https://kubix1.cookingnumbers.com/create" -H "Content-Type: application/json" -d @./data1.json
#curl -X POST "https://kubix1.cookingnumbers.com/createshared" -H "Content-Type: application/json" -d @./datashared1.json
echo ""
curl -X GET "https://kubix1.cookingnumbers.com/read/1"

echo ""
curl -X GET "https://kubix1.cookingnumbers.com/readshared/2"

