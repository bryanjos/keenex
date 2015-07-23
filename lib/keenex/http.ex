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
  def auth_headers([key: key], headers) do
    Dict.put(headers, :Authorization, get_key(key))
  end

  def auth_headers(method, headers) when method in ~w(put post patch delete options)a do
    auth_headers([key: :write], headers)
  end

  def auth_headers(_method, headers) do
    auth_headers([key: :read], headers)
  end

  def process_arguments(method, url, options) do
    args = super(method, url, options)
    key  = options[:key]

    unless (is_nil(key)) do
      method = [key: key]
    end

    headers = auth_headers(method, args[:headers])
    %{args | :headers => headers}
  end

  defp get_key(key_type) do
    case key_type do
      :write ->
        Keenex.write_key()
      :read ->
        Keenex.read_key()
    end
  end

  def process_request_body(body) do
    Enum.into(body, %{})
    |> Poison.encode!
  end

  defp handle_response(response) do
    response = super(response)

    case HTTPotion.Response.success?(response) do
      true ->
        {:ok, response.body}
      false ->
        {:error, response.body}
    end
  end
end
