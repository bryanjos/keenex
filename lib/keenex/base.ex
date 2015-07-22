defmodule Keenex.Base do
  alias Keenex.Http
  alias Keenex.URL

  @moduledoc false

  def get(endpoint, query \\ []) do
    {url, _body} = request_params(endpoint, query)

    Http.get(url)
    |> to_response
  end

  def post(endpoint, body, options \\ []) do
    {url, body} = request_params(endpoint, body)
    Http.post(url, options |> Dict.put(:body, Poison.encode!(body)))
    |> to_response
  end

  def post(endpoint) do
    post(endpoint, "")
    |> to_response
  end

  def put(endpoint, body, options \\ []) do
    {url, body} = request_params(endpoint, body)
    Http.put(url, options |> Dict.put(:body, Poison.encode!(body)))
    |> to_response
  end

  def put(endpoint) do
    put(endpoint, "")
    |> to_response
  end

  def delete(endpoint) do
    url(endpoint)
    |> Http.delete
    |> to_response
  end

  # Helpers

  def to_response({status, response}) do
    {status, Poison.decode!(response)}
  end

  def make_url(endpoint, query \\ []) do
    ["projects", Keenex.project_id, endpoint]
    |> URL.encode(query)
  end

  def url(endpoint, query \\ []) do
    make_url(endpoint, query)
  end

  def request_params(endpoint, query \\ []) do
    {query, body} = parse_query_body(query)
    url = make_url(endpoint, query)
    {url, body}
  end

  def parse_body(query) do
    Enum.map( query, fn ({k, v}) ->
      cond do
        is_list(v) or is_map(v) ->
          {k, v}
        true -> nil
        end
    end)
    |> Enum.reject(fn (q) -> is_nil(q) end)
    |> Enum.into(%{})
  end

  def parse_query(query) do
    Enum.reject(query, fn ({_k, v}) ->
      is_list(v) or is_map(v)
    end)
  end

  def parse_query_body(query) do
    body  = parse_body(query)
    query = parse_query(query)
    {query, body}
  end
end
