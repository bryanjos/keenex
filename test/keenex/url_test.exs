defmodule Keenex.URL.Test do
  use ExUnit.Case, async: false

  alias Keenex.URL

  test "string endpoint" do
    url_base = "queries/count"
    url = URL.encode(url_base)
    assert url == url_base
  end

  test "string endpoint with empty list of query params" do
    url_base = "queries/count"
    url = URL.encode(url_base, [])
    assert url == url_base
  end

  test "string endpoint with map of query params" do
    url_base = "queries/count"
    url = URL.encode(url_base, %{key: "value"})
    assert url == "#{url_base}?key=value"
  end

  test "string endpoint with a tuple of query params" do
    url_base = "queries/count"
    url = URL.encode(url_base, key: "value")
    assert url == "#{url_base}?key=value"
  end

  test "list of endpoint" do
    url = URL.encode(~w(queries count))
    assert url == "queries/count"
  end

  test "list of endpoint with query params" do
    url = URL.encode(~w(queries count), key: "value")
    assert url == "queries/count?key=value"
  end
end
