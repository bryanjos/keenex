defmodule Keenex.Base do
  alias Keenex.Http
  alias Keenex.URL

  @moduledoc false

  def url(endpoint, query \\ []) do
    ["projects", Keenex.project_id, endpoint]
    |> URL.encode(query)
  end

  def get(endpoint, query \\ []) do
    url(endpoint, query)
    |> Http.get
    |> to_response
  end

  def post(endpoint, data) do
    url(endpoint)
    |> Http.post(Poison.encode!(data))
    |> to_response
  end

  def post(endpoint) do
    post(endpoint, "")
    |> to_response
  end

  def put(endpoint, data) do
    url(endpoint)
    |> Http.put(Poison.encode!(data))
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

  def to_response({status, response}) do
    {status, Poison.decode!(response)}
  end
end
