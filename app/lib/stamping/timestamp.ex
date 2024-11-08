defmodule LogStream.Stamping.Timestamp do
  def stamp(message) do
    message
    |> add_ingestion_timestamp
  end

  defp add_ingestion_timestamp(message) do
    now = DateTime.to_iso8601(DateTime.now!("Etc/UTC"))

    message
    |> Map.merge(%{"log_management" => %{"@ingestion_timestamp": now}}, fn _k, v1, v2 ->
      Map.merge(v1, v2)
    end)
  end
end
