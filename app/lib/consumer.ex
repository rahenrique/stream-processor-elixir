defmodule LogStream.Consumer do
  require Logger

  @bulk_size Application.compile_env!(:log_stream, :consumer_bulk_size)
  @opensearch_url Application.compile_env!(:log_stream, :opensearch_url)
  @opensearch_endpoint "/_bulk"

  def handle_messages(messages) do
    Logger.info("#{inspect(self())} will process #{length(messages)} logs")

    headers = [{"content-type", "application/json"}]
    indexer = "/log-search-" <> Calendar.strftime(DateTime.now!("Etc/UTC"), "%Y-%m-%d")
    url = @opensearch_url <> indexer <> @opensearch_endpoint

    HTTPoison.start()

    for bulk_messages <- Enum.chunk_every(messages, @bulk_size) do
      bulk_body = Enum.reduce(bulk_messages, "", fn %{key: _key, value: msg} = _message, acc -> acc <> build_bulk_payload(msg) end)

      case HTTPoison.post(url, bulk_body, headers, []) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          body_decoded = Poison.decode!(body)

          case body_decoded do
            %{"errors" => true, "items" => items} ->
              log_inserted_messages(
                length(bulk_messages) - length(items),
                length(bulk_messages),
                body_decoded
              )

            _ ->
              log_inserted_messages(
                length(Map.get(body_decoded, "items", [])),
                length(bulk_messages),
                body_decoded
              )
          end

        {:ok, %HTTPoison.Response{status_code: 404}} ->
          Logger.error("#{url} not found")

        {:ok, %HTTPoison.Response{status_code: 429, body: body}} ->
          Logger.error(body)

        {:error, %HTTPoison.Error{reason: reason}} ->
          Logger.error(reason)

        _ ->
          Logger.error("Error inserting log")
      end

      # TODO: test an alternative using Tasks
      # Task.start_link(fn -> HTTPoison.post!(url, body, headers, []) end)

      Logger.notice("#{inspect(self())} finished processing #{length(messages)} logs")
    end

    :ok
  end

  def build_bulk_payload(message) do
    body =
      message
      |> Poison.decode!()
      |> LogStream.Stamping.Timestamp.stamp()
      |> LogStream.Enrichment.Geolocalization.enrich()
      |> Poison.encode!()

    "{\"index\":{}}" <> "\n" <> body <> "\n"
  end

  def log_inserted_messages(inserted, processed, _body) when inserted == processed do
    Logger.info("#{inspect(self())} inserted #{inserted} logs")
  end

  def log_inserted_messages(inserted, processed, body) do
    Logger.warning("#{inspect(self())} lost #{processed - inserted}, inserted #{inserted} of #{processed} processed logs")
    Logger.warning(inspect(body))
  end
end
