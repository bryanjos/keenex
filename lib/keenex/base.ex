defmodule Keenex.Base do
  alias Keenex.Http

  @moduledoc false

  def url(endpoint) when is_list(endpoint) do
    endpoint
      |> List.wrap
      |> List.flatten
      |> Enum.reject(fn(s) -> is_nil(s) or s === "" end)
      |> Enum.join("/")
      |> url
  end

  def url(endpoint) when is_bitstring(endpoint) do
    "projects/#{Keenex.project_id}/" <> endpoint
  end

  def get(endpoint) do
    url(endpoint)
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
