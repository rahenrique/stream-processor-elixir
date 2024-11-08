.DEFAULT_GOAL := help

.PHONY: help ## Prints this help message
help:
	@echo "========================================================================================"
	@echo "Makefile: Use 'make <target>' where <target> is one of the following commands:"
	@echo ""
	@grep -E '^\.PHONY: [a-zA-Z_-]+ .*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = "(: |##)"}; {printf "\033[36m%-16s\033[0m %s\n", $$2, $$3}'
	@echo ""
	@echo "========================================================================================"
	@echo "To prepare Python in a virtual environment to execute tests, please run:"
	@echo ""
	@echo "uv sync --frozen"
	@echo "source python_producer./.venv/bin/activate"
	@echo "make produce-logs"
	@echo ""


.PHONY: build ## Create newtork, run dependencies, create kafka topics, build stream processor
build:
	@echo "Creating stream_processor_network network..."
	docker network create stream_processor_network || true
	@echo "Creating kafka and opensearch containers..."
	docker compose up -d --build --force-recreate zookeeper kafka kafdrop opensearch-node1 opensearch-dashboards
	@echo "Creating kafka topics..."
	docker exec -it kafka kafka-topics.sh --bootstrap-server localhost:9092 --topic log.ingestion --create --partitions 10 || true
	@echo "Building stream processor..."
	docker compose build stream_processor


# docker compose up -d --build --scale stream_processor=5 stream_processor
# docker stack deploy --compose-file docker-compose.yml stream_processor
.PHONY: up ## Run stream processor container
up:
	@echo "Creating stream processor containers..."
	docker compose up stream_processor


.PHONY: stop-processor ## Stop the stream processor container (useful for tests)
stop-processor:
	docker stop stream_processor


.PHONY: start-processor ## Start the stream processor container (useful for tests)
start-processor:
	docker start stream_processor


.PHONY: down ## Stops and remove containers (docker compose down --remove-orphans)
down:
	docker compose down --remove-orphans


.PHONY: purge ## Stops, remove containers and volumes (docker compose down --remove-orphans --volumes)
purge:
	docker compose down --remove-orphans --volumes


.PHONY: create-topics ## Create kafka topics
create-topics:
	docker exec -it kafka kafka-topics.sh --bootstrap-server localhost:9092 --topic log.ingestion --create --partitions 10


.PHONY: iex ## Run stream processor with iex (docker exec -it stream_processor sh -c "iex -S mix")
iex:
	@echo "========================================================================================"
	@echo "This will run stream_processor, with an iex terminal prompt"
	@echo "To test the application, run:"
	@echo 'LogStream.Producer.send_my_message({"my_key", "Some value"}, "log.ingestion")'
	@echo "========================================================================================"
	@echo ""
	docker exec -it stream_processor sh -c "iex -S mix"


.PHONY: produce-logs ## Run python kafka_producer_test.py to produce logs
produce-logs:
	python python_producer/kafka_producer_test.py
