defmodule Keenex.Base do
  alias Keenex.Http
  alias Keenex.URL

  @moduledoc false

  def get(endpoint, query \\ []) do
    url_encode(endpoint, query)
    |> Http.get
    |> to_response
  end

  def post(endpoint, body, options \\ []) do
    options = Dict.put(options, :body, body)

    url_encode(endpoint)
    |> Http.post(options)
    |> to_response
  end

  def post(endpoint) do
    post(endpoint, "")
  end

  def put(endpoint, body, options \\ []) do
    options = Dict.put(options, :body, body)

    url_encode(endpoint)
    |> Http.put(options)
    |> to_response
  end

  def put(endpoint) do
    put(endpoint, "")
  end

  def delete(endpoint, query \\ []) do
    url_encode(endpoint, query)
    |> Http.delete
    |> to_response
  end

  # Helpers

  def to_response({status, response}) do
    {status, Poison.decode!(response)}
  end

  def url_encode(endpoint, query \\ []) do
    ["projects", Keenex.project_id, endpoint]
    |> List.flatten
    |> URL.encode(query)
  end
end
