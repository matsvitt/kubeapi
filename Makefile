default: all


.PHONY: chart upgrade xhelm

run:
	uvicorn app:app --reload

runt:
	docker run -v /home/matthias/src/kubeapi/data:/data -v /home/matthias/src/kubeapi/datashared:/datashared -p 8900:8000 docker.io/matsvitt/kubetestapix:latest

post1:
	curl -X POST "http://127.0.0.1:8000/create" -H "Content-Type: application/json" -d '{"id": 1, "data": "example data"}'

post2:
	curl -X POST "http://127.0.0.1:8000/createshared" -H "Content-Type: application/json" -d '{"id": 2, "data": "shared data"}'

get1:
	curl -X GET "http://127.0.0.1:8000/read/1"

get2:
	curl -X GET "http://127.0.0.1:8000/readshared/2"



rebuild: build push

build:
	docker build -t matsvitt/kubetestapix .

push:
	docker push matsvitt/kubetestapix


all: yaml chart

yaml:
	bin/kompose convert
	mkdir -p helm_input
	rm -rf helm_input/*yaml
	mkdir -p kubapitestchart
	mv kubetestapi*yaml helm_input
	rm -rf kubapitestchart

helmify:
	wget https://github.com/arttor/helmify/releases/download/v0.4.17/helmify_Linux_x86_64.tar.gz
	tar xvzf helmify_Linux_x86_64.tar.gz
	mv helmify bin
	chmod +x bin/helmify
	rm -rf helmify_Linux_x86_64.tar.gz*

chart:
	mkdir -p kubetestapichart
	rm -rf kubetestapichart/*
	bin/helmify -f ./helm_input -r kubetestapichart


install:
	helm install kubeapitest1 kubetestapichart/ --namespace caddy-system

uninstall:
	helm uninstall kubeapitest1 --namespace caddy-system


upgrade:
	helm upgrade kubeapitest1 kubetestapichart/ --namespace caddy-system


xhelm: chart upgrade
