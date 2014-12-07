defmodule Keenex.Base do
  alias Keenex.Http

  @moduledoc false

  def get(keen, key_type, endpoint, id) do
    key = get_key(keen, key_type)
    Http.get("#{endpoint}/#{id}", key)
    |> to_response
  end

  def post(keen, key_type, endpoint, data) do
    key = get_key(keen, key_type)
    Http.post(endpoint, key, Poison.encode!(data))
    |> to_response
  end

  def post(keen, key_type, endpoint) do 
    post(keen, key_type, endpoint, "")
  end

  def put(keen, key_type, endpoint, data) do
    key = get_key(keen, key_type)
    Http.put(endpoint, key, Poison.encode!(data))
    |> to_response
  end

  def put(keen, key_type, endpoint) do 
    put(keen, key_type, endpoint, "")
  end

  def delete(keen, key_type, endpoint, id) do
    key = get_key(keen, key_type)
    Http.delete("#{endpoint}/#{id}", key)
    |> to_response
  end

  def get_key(keen, key_type) do
    case key_type do
      :write ->
        Keenex.write_key(keen)
      :read ->
        Keenex.read_key(keen)
    end
  end

  def to_response({status, response}) do
    {status, Poison.decode!(response)}
  end
end