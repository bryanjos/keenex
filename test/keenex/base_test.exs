defmodule Keenex.Base.Test do
  use ExUnit.Case, async: false

  alias Keenex.Helpers
  alias Keenex.Base

  setup_all do
    {:ok, keen } = Helpers.new_keenex
    {:ok, [keen: keen] }
  end

  defp project_url do
    "projects/#{Keenex.project_id}"
  end

  test "should url with project_id from bitstring" do
    assert Base.url("queries/count") == "#{project_url}/queries/count"
  end

  test "should url with project_id and query params" do
    assert Base.url(~w(queries count), start: :true) == "#{project_url}/queries/count?start=true"
  end

  test "list of endpoint with map in query params" do
    filters = [%{
      operator: "eq",
      property_name: "url",
      property_value: "https://github.com/azukiapp/feedbin"
    }]

    params = [
      event_collection: "start",
      filters: filters,
    ]

    {url, body} = Base.request_params(~w(queries count), params)

    assert url  == "projects/#{Keenex.project_id}/queries/count?event_collection=start"
    assert body == %{filters: filters}

    {status, _response} = Base.post(~w(queries count), params, key: :master)
    assert status == :ok
  end
end
