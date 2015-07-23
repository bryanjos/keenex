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
    assert Base.url_encode("queries/count") == "#{project_url}/queries/count"
  end

  test "should url with project_id and query params" do
    assert Base.url_encode(~w(queries count), start: :true) == "#{project_url}/queries/count?start=true"
  end

  test "list of endpoint with map in query params" do
    endpoint = [~w(queries count), event_collection: "start",]
    params   =
      [
        filters: [%{
          operator: "eq",
          property_name: "url",
          property_value: "https://github.com/azukiapp/feedbin"
        }]
      ]

    {status, _response} = Base.post(endpoint, params, key: :read)
    assert status == :ok
  end
end
