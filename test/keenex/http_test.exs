defmodule Keenex.Http.Test do
  use ExUnit.Case, async: false

  alias Keenex.Http

  test "process empty request body " do
    body = Http.process_request_body("")
    assert body == ""
  end

  test "process list request body" do
    params =
      [
        filters: [%{
          operator: "eq",
          property_name: "url",
          property_value: "https://github.com/azukiapp/feedbin"
        }]
      ]

    body = Http.process_request_body(params)
    should =
      Enum.into(params, %{})
      |> Poison.encode!

    assert body == should
  end
end
