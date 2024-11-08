defmodule LogStream.Enrichment.Geolocalization do
  require Logger

  def enrich(message) do
    source_ip = get_in(message, ["source_ip"])
    destination_ip = get_in(message, ["destination_ip"])

    message
    |> enrich_by_ip(source_ip, :source)
    |> enrich_by_ip(destination_ip, :destination)
    |> add_enrichment_timestamp
  end

  defp enrich_by_ip(message, ip, _target) when ip == nil, do: message

  defp enrich_by_ip(message, ip, target) do
    geodata = ip |> Geolix.lookup()

    case geodata do
      %{geolite2_city: nil} -> message
      %{geolite2_city: data} -> enrich_message(message, data, target)
      _ -> message
    end
  end

  defp enrich_message(message, %{city: city, country: country, location: location, postal: postal} = _geodata, target) do
    enriched_data =
      %{geo: %{}}
      |> put_in([:geo, :country_iso_code], Map.get(country, :iso_code))
      |> put_in([:geo, :country_name], Map.get(country, :name))
      |> put_in([:geo, :city_name], Map.get(city, :name))
      |> put_in([:geo, :postal_code], Map.get(postal, :code))
      |> put_in([:geo, :location], %{lat: Map.get(location, :latitude), lon: Map.get(location, :longitude)})

    message
    |> Map.merge(%{target => enriched_data}, fn _k, v1, v2 -> Map.merge(v1, v2) end)
  end

  defp add_enrichment_timestamp(message) do
    now = DateTime.to_iso8601(DateTime.now!("Etc/UTC"))

    enrichment_timestamp = %{
      enrichment: %{"@timestamp": now, message: "Successfully enriched event"}
    }

    message
    |> Map.merge(%{"log_management" => enrichment_timestamp}, fn _k, v1, v2 ->
      Map.merge(v1, v2)
    end)
  end
end
