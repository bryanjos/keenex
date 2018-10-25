defmodule Keenex.EventCollections.Test do
  use Keenex.HttpCase, async: true
  alias Plug.Conn

  test "post new start event", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/events/start", fn conn ->
      Conn.resp(conn, 200, "{\"tacos\": [{\"success\": true}]}")
    end)

    data = %{
      url: "https://github.com/azukiapp/azk",
      host: "github.com",
      repo_user: "azukiapp",
      repo_basename: "azk"
    }

    {status, _} = Keenex.add_event("start", data)
    assert status == :ok
  end

  test "get event collection schema", %{bypass: bypass} do
    Bypass.expect_once(bypass, "GET", "/projects/project_id/events/start", fn conn ->
      Conn.resp(
        conn,
        200,
        "{\"properties\": {\"keen.created_at\": \"datetime\", \"repo_basename\": \"string\", \"repo_user\": \"string\", \"keen.id\": \"string\", \"url\": \"string\", \"host\": \"string\", \"keen.timestamp\": \"datetime\"}}"
      )
    end)

    {status, _} = Keenex.inspect("start")
    assert status == :ok
  end
end
