defmodule Keenex.Base do
  alias Keenex.Http

  @moduledoc false

  def get(key_type, endpoint, id) do
    key = get_key(key_type)
    Http.get("#{endpoint}/#{id}", key)
    |> to_response
  end

  def post(key_type, endpoint, data) do
    key = get_key(key_type)
    Http.post(endpoint, key, Poison.encode!(data))
    |> to_response
  end

  def post(key_type, endpoint) do 
    post(key_type, endpoint, "")
  end

  def put(key_type, endpoint, data) do
    key = get_key(key_type)
    Http.put(endpoint, key, Poison.encode!(data))
    |> to_response
  end

  def put(key_type, endpoint) do 
    put(key_type, endpoint, "")
  end

  def delete(key_type, endpoint, id) do
    key = get_key(key_type)
    Http.delete("#{endpoint}/#{id}", key)
    |> to_response
  end

  def get_key(key_type) do
    case key_type do
      :write ->
        Keenex.write_key()
      :read ->
        Keenex.read_key()
    end
  end

  def to_response({status, response}) do
    {status, Poison.decode!(response)}
  end
end