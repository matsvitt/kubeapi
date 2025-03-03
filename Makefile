default: run

run:
	uvicorn app:app --reload

post1:
	curl -X POST "http://127.0.0.1:8000/create" -H "Content-Type: application/json" -d '{"id": 1, "data": "example data"}'

post2:
	curl -X POST "http://127.0.0.1:8000/createshared" -H "Content-Type: application/json" -d '{"id": 2, "data": "shared data"}'

get1:
	curl -X GET "http://127.0.0.1:8000/read/1"

get2:
	curl -X GET "http://127.0.0.1:8000/readshared/2"


build:
	docker build -t kubeapi .

yaml:
	bin/kompose convert


