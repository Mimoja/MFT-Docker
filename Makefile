all: docker-run

docker-run:
	mkdir -p ./workspace/elastic && chmod  0777 workspace/elastic && docker-compose up

docker-baseimage:
	docker build -t go-yara docker/yara
