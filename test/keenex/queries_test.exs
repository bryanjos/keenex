defmodule Keenex.Queries.Test do
  use Keenex.HttpCase, async: true
  alias Plug.Conn

  test "count", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/count", fn conn ->
      Conn.resp(conn, 200, "{\"result\": 8}")
    end)

    {status, _} = Keenex.count("start", %{})
    assert status == :ok
  end

  test "count: only required", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/count", fn conn ->
      Conn.resp(conn, 200, "{\"result\": 9}")
    end)

    {status, _} = Keenex.count("start")
    assert status == :ok
  end

  test "count_unique", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/count_unique", fn conn ->
      Conn.resp(conn, 200, "{\"result\": 1}")
    end)

    {status, _} = Keenex.count_unique("start", "host")
    assert status == :ok
  end

  test "minimum", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/minimum", fn conn ->
      Conn.resp(conn, 200, "{\"result\": \"github.com\"}")
    end)

    {status, _} = Keenex.minimum("start", "host")
    assert status == :ok
  end

  test "maximum", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/maximum", fn conn ->
      Conn.resp(conn, 200, "{\"result\": \"github.com\"}")
    end)

    {status, _} = Keenex.maximum("start", "host")
    assert status == :ok
  end

  test "sum", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/sum", fn conn ->
      Conn.resp(conn, 200, "{\"result\": 0}")
    end)

    {status, _} = Keenex.sum("start", "host")
    assert status == :ok
  end

  test "average", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/average", fn conn ->
      Conn.resp(conn, 200, "{\"result\": 0}")
    end)

    {status, _} = Keenex.average("start", "host")
    assert status == :ok
  end

  test "median", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/median", fn conn ->
      Conn.resp(conn, 200, "{\"result\": 0}")
    end)

    {status, _} = Keenex.median("start", "host")
    assert status == :ok
  end

  test "percentile", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/percentile", fn conn ->
      Conn.resp(conn, 200, "{\"result\": null}")
    end)

    {status, _} = Keenex.percentile("start", "host", 10)
    assert status == :ok
  end

  test "select_unique", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/select_unique", fn conn ->
      Conn.resp(conn, 200, "{\"result\": [\"github.com\"]}")
    end)

    {status, _} = Keenex.select_unique("start", "host")
    assert status == :ok
  end

  test "multi_analysis", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/multi_analysis", fn conn ->
      Conn.resp(conn, 200, "{\"result\": {\"sum\": 0, \"median\": null}}")
    end)

    analyses = %{
      sum: %{
        analysis_type: "sum",
        target_property: "host"
      },
      median: %{
        analysis_type: "median",
        target_property: "host"
      }
    }

    {status, _} = Keenex.multi_analysis("start", analyses)
    assert status == :ok
  end

  test "funnel", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/funnel", fn conn ->
      Conn.resp(
        conn,
        200,
        "{\"steps\": [{\"with_actors\": false, \"actor_property\": \"host\", \"filters\": [], \"timeframe\": \"this_7_days\", \"timezone\": null, \"event_collection\": \"start\", \"optional\": false, \"inverted\": false}], \"result\": [1]}"
      )
    end)

    steps = [
      %{
        event_collection: "start",
        actor_property: "host",
        timeframe: "this_7_days"
      }
    ]

    {status, _} = Keenex.funnel(steps)
    assert status == :ok
  end

  test "extraction", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/queries/extraction", fn conn ->
      Conn.resp(
        conn,
        200,
        "{\"result\":[{\"repo_basename\": \"azk\", \"keen\": {\"timestamp\": \"2016-05-25T23:30:04.531Z\", \"created_at\": \"2016-05-25T23:30:04.531Z\", \"id\": \"5746357cc9e1633f51d4c398\"}, \"host\": \"github.com\", \"repo_user\": \"azukiapp\", \"url\": \"https://github.com/azukiapp/azk\"}, {\"repo_basename\": \"azk\", \"keen\": {\"timestamp\": \"2016-05-28T17:09:59.633Z\", \"created_at\": \"2016-05-28T17:09:59.633Z\", \"id\": \"5749d0e7c9e1633f3e8cd6f9\"}, \"host\": \"github.com\", \"repo_user\": \"azukiapp\", \"url\": \"https://github.com/azukiapp/azk\"}, {\"repo_basename\": \"azk\", \"keen\": {\"timestamp\": \"2016-05-28T17:14:18.024Z\", \"created_at\": \"2016-05-28T17:14:18.024Z\", \"id\": \"5749d1ea36bca453b99cfb7f\"}, \"host\": \"github.com\", \"repo_user\": \"azukiapp\", \"url\": \"https://github.com/azukiapp/azk\"}, {\"repo_basename\": \"azk\", \"keen\": {\"timestamp\": \"2016-05-28T17:17:46.945Z\", \"created_at\": \"2016-05-28T17:17:46.945Z\", \"id\": \"5749d2bae8617032660cbceb\"}, \"host\": \"github.com\", \"repo_user\": \"azukiapp\", \"url\": \"https://github.com/azukiapp/azk\"}, {\"repo_basename\": \"azk\", \"keen\": {\"timestamp\": \"2016-05-28T17:18:56.661Z\", \"created_at\": \"2016-05-28T17:18:56.661Z\", \"id\": \"5749d300e8617032763274c5\"}, \"host\": \"github.com\", \"repo_user\": \"azukiapp\", \"url\": \"https://github.com/azukiapp/azk\"}, {\"repo_basename\": \"azk\", \"keen\": {\"timestamp\": \"2016-05-28T17:23:51.755Z\", \"created_at\": \"2016-05-28T17:23:51.755Z\", \"id\": \"5749d427e86170326b0fe2dd\"}, \"host\": \"github.com\", \"repo_user\": \"azukiapp\", \"url\": \"https://github.com/azukiapp/azk\"}, {\"repo_basename\": \"azk\", \"keen\": {\"timestamp\": \"2016-05-28T17:36:48.667Z\", \"created_at\": \"2016-05-28T17:36:48.667Z\", \"id\": \"5749d73036bca453c0170f0c\"}, \"host\": \"github.com\", \"repo_user\": \"azukiapp\", \"url\": \"https://github.com/azukiapp/azk\"}, {\"repo_basename\": \"azk\", \"keen\": {\"timestamp\": \"2016-05-29T14:44:12.298Z\", \"created_at\": \"2016-05-29T14:44:12.298Z\", \"id\": \"574b003cc9e1633f52914d7d\"}, \"host\": \"github.com\", \"repo_user\": \"azukiapp\", \"url\": \"https://github.com/azukiapp/azk\"}, {\"repo_basename\": \"azk\", \"keen\": {\"timestamp\": \"2016-05-29T14:45:42.814Z\", \"created_at\": \"2016-05-29T14:45:42.814Z\", \"id\": \"574b0096e86170326dee394f\"}, \"host\": \"github.com\", \"repo_user\": \"azukiapp\", \"url\": \"https://github.com/azukiapp/azk\"}]}"
      )
    end)

    {status, _} = Keenex.extraction("start")
    assert status == :ok
  end
end
