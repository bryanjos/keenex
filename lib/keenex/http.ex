defmodule Keenex.Http do
  use HTTPotion.Base

  @moduledoc false
  @url "https://api.keen.io/3.0/"
  @options [timeout: 10000]

  @headers ["Content-Type": "application/json"]

  def process_url(url) do
    @url <> url
  end

  def process_request_headers(custom_headers \\ []) do
    @headers ++ custom_headers
  end

  # Add the authorization key based on the request method
  def auth_headers(method, headers) when method in ~w(put post patch delete options)a do
    Dict.put(headers, :Authorization, get_key(:write))
  end

  def auth_headers(_method, headers) do
    Dict.put(headers, :Authorization, get_key(:read))
  end

  def request(method, url, body, headers, options) do
    super(method, url, body, auth_headers(method, headers), options)
    |> handle_response
  end

  defp get_key(key_type) do
    case key_type do
      :write ->
        Keenex.write_key()
      :read ->
        Keenex.read_key()
    end
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
