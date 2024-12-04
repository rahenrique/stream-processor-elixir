# Log Stream Processor in Elixir

Stream Processor in Elixir, with Kafka and Opensearch

## Running the project

There are various commands in a Makefile, to help running the project in the most straightforward way.
All dependencies like Kafka and Opensearch are available in docker containers. To simply run all the containers, generate logs and see the processor in action, use the following commands:

1. Download and build all the dependencies 
```bash
make build
```

2. Prepare a virtual environment for the log producer (it uses Python) 
```bash
cd python_producer && uv sync --frozen
cd ..
source python_producer/.venv/bin/activate
```

3. Produce some logs, and send them to Kafka. You can inspect the messages using Kafdrop at http://localhost:9000
```bash
make produce-logs
```

4. Run the stream processor container
```bash
make up
```

It's possible to inspect the processed logs in Opensearch, using Opensearch Dashboards at http://localhost:8000. When accessing OpenSearch for the first time, it may be necessary to set indexes before the messages appear in the dashboard.
