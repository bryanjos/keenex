defmodule Keenex.URL do
  @doc """
    Process URL arguments
    - Adding base url https:// ...
    - Join list with "/"
    - Adding query params

    iex> Keenex.URL.encode(["queries", "count"], event_collection: "start", test: "data", old: "new")
  """
  def encode(endpoint), do: encode(endpoint, [])

  def encode(endpoint, query) when is_list(endpoint) do
    endpoint
    |> List.flatten
    |> Enum.reject(fn(s) -> is_nil(s) or not is_bitstring(s) or s === "" end)
    |> Enum.join("/")
    |> encode(query)
  end

  def encode(endpoint, query) when is_bitstring(endpoint) do
    # unless (endpoint =~ ~r/^projects/) do
    #   endpoint =
    #     ["projects", Keenex.project_id, endpoint]
    #     |> encode([])
    # end

    query = URI.encode_query(query)

    [endpoint, query]
    |> Enum.reject(fn(s) -> is_nil(s) or not is_bitstring(s) or s === "" end)
    |> Enum.join("?")
  end

end
