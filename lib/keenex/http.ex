defmodule Keenex.HTTP do

  @moduledoc false
  @url "https://api.keen.io/3.0"

  @headers ["Content-Type": "application/json"]


  def get(endpoint) do
    headers = [{"Authorization", get_key(:read)}]
    HTTPoison.get(@url <> endpoint, Keyword.merge(@headers, headers))
    |> handle_response
  end

  def post(endpoint, data, key_type \\ :write) do
    headers = [{"Authorization", get_key(key_type)}]
    HTTPoison.post(@url <> endpoint, Poison.encode!(data), Keyword.merge(@headers, headers))
    |> handle_response
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: status_code} = response } when status_code in 200..299 ->
        {:ok, Poison.decode!(response.body) }

      {:ok, %HTTPoison.Response{status_code: status_code} = response } when status_code in 400..599 ->
        {:error, Poison.decode!(response.body) }

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{ reason: reason } }
    end
  end

  defp get_key(key_type) do
    case key_type do
      :write ->
        Keenex.write_key()
      :read ->
        Keenex.read_key()
    end
  end
end
