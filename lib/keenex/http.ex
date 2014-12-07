defmodule Keenex.Http do
  @moduledoc false
  @contentType  ["Content-Type": "application/json"]
  @url "https://api.keen.io/3.0/"
  @options [timeout: 10000]

  def get(endpoint, key) do
    headers = Enum.concat(@contentType, [ "Authorization": key ])
    HTTPotion.get(@url <> endpoint, headers, options: @options) 
    |> handle_response
  end

  def post(endpoint, key, body) do
    headers = Enum.concat(@contentType, [ "Authorization": key ])
    HTTPotion.post(@url <> endpoint, body, headers, options: @options) 
    |> handle_response
  end

  def put(endpoint, key, body) do
    headers = Enum.concat(@contentType, [ "Authorization": key ])
    HTTPotion.put(@url <> endpoint, body, headers, options: @options) 
    |> handle_response
  end

  def delete(endpoint, key) do
    headers = Enum.concat(@contentType, [ "Authorization": key ])
    HTTPotion.delete(@url <> endpoint, headers, options: @options) 
    |> handle_response
  end

  defp handle_response(response) do
    case HTTPotion.Response.success?(response) do
      true ->
        {:ok, response.body}
      false ->
        {:error, response.body}         
    end
  end
end