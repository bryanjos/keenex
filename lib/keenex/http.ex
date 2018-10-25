defmodule Keenex.HTTP do
  @moduledoc false

  @headers ["Content-Type": "application/json"]

  defp url do
    Application.get_env(:keenex, :url, "https://api.keen.io/3.0")
  end

  def get(endpoint) do
    headers = [Authorization: Keenex.get_key(:read)]
    opts = Keenex.httpoison_opts()

    (url() <> endpoint)
    |> HTTPoison.get(Keyword.merge(@headers, headers), opts)
    |> handle_response
  end

  def post(endpoint, data, key_type \\ :write) do
    headers = [Authorization: Keenex.get_key(key_type)]
    opts = Keenex.httpoison_opts()

    (url() <> endpoint)
    |> HTTPoison.post(Jason.encode!(data), Keyword.merge(@headers, headers), opts)
    |> handle_response
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: status_code} = response}
      when status_code in 200..299 ->
        {:ok, Jason.decode!(response.body)}

      {:ok, %HTTPoison.Response{status_code: status_code} = response}
      when status_code in 400..599 ->
        IO.inspect(response)
        {:error, Jason.decode!(response.body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{reason: reason}}
    end
  end
end
