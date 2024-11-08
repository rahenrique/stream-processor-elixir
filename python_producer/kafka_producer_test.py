import datetime
import json
import random
import time
import uuid

from kafka import KafkaProducer
from kafka.errors import KafkaError

from logs import LOG_TEMPLATES


def publish_messages(
        eps=5_000,
        bulks=5, 
        topic="log.ingestion"
):
    try:
        producer_instance = KafkaProducer(bootstrap_servers=json.loads('["localhost:9093"]'))
        logs_length = len(LOG_TEMPLATES)
        
        for s in range(bulks):
            
            print(f"Generating {eps} logs...")

            for i in range(eps):
                payload = LOG_TEMPLATES[i%logs_length]
                producer_instance.send(topic, bytes(json.dumps(payload), "utf-8"))
                
            print(f"Waiting...")
            time.sleep(0.25)

        producer_instance.flush()
        producer_instance.close()

    except KafkaError as error:
        print(f"Exception in publishing message: {error}")

    print(f"Finished producing logs")


if __name__ == "__main__":
    publish_messages()
