import Config

config :logger, level: :notice

config :kaffe,
  producer: [
    endpoints: [kafka: 9092],
    topics: ["log.ingestion"]
  ]

config :kaffe,
  consumer: [
    endpoints: [kafka: 9092],
    topics: ["log.ingestion"],
    consumer_group: "log_stream_consumers",
    message_handler: LogStream.Consumer,
    offset_reset_policy: :reset_to_earliest,
    max_bytes: 10_000_000,
    worker_allocation_strategy: :worker_per_topic_partition,
    start_with_earliest_message: true
  ]

config :geolix,
  databases: [
    %{
      id: :geolite2_city,
      adapter: Geolix.Adapter.MMDB2,
      source: Path.expand("./lib/enrichment/Geo-City.mmdb")
    }
  ]

config :log_stream, :opensearch_url, "http://opensearch:9200"
config :log_stream, :consumer_bulk_size, 200

import_config "#{Mix.env()}.exs"
