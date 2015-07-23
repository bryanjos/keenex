defmodule Keenex.URL do
  @doc """
    Process URL arguments
    - Adding base url https:// ...
    - Join list with "/"
    - Adding query params

    iex> Keenex.URL.encode(["queries", "count", event_collection: "start"], filters: [test: "data", old: "new"])
      "queries/count?event_collection=start"
  """
  def encode(endpoint), do: encode(endpoint, [])

  def encode(endpoint, query) do
    query    = encode_query(endpoint, query)
    endpoint = encode_endpoint(endpoint)

    compact([endpoint, query])
    |> Enum.join("?")
  end

  def encode_endpoint(endpoint) do
    compact(endpoint)
    |> Enum.join("/")
  end

  def encode_query(endpoint, query) do
    parse_query(endpoint, query)
    |> URI.encode_query
  end

  @doc """
  Fetch all queries from list
  """
  def parse_query(query) do
    parse_query(query, %{})
  end

  def parse_query(query, acc) when not is_map(acc) do
    parse_query([query, acc], %{})
  end

  def parse_query([head|tail], acc) do
    head = parse_query(head, acc)
    parse_query(tail, head)
  end

  def parse_query({_, v}, acc) when is_list(v), do: acc

  def parse_query({k, v}, acc) do
    Dict.put(acc, k, v)
  end

  def parse_query(query, acc) when is_map(query) do
    Dict.merge(acc, query)
  end

  def parse_query(query, acc) when is_bitstring(query), do: acc

  def parse_query([], acc), do: acc


  """
  Remove nil and not bitstring and empty values of list
  """
  defp compact(list) do
    list
    |> List.wrap
    |> List.flatten
    |> Enum.reject(fn(s) -> is_nil(s) or not is_bitstring(s) or s === "" end)
  end
end
