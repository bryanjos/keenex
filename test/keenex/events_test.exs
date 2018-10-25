defmodule Keenex.Events.Test do
  use Keenex.HttpCase, async: true
  alias Plug.Conn

  test "post events", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/projects/project_id/events", fn conn ->
      Conn.resp(conn, 200, "{\"tacos\": [{\"success\": true}]}")
    end)

    {status, _response} = Keenex.add_events(%{tacos: [%{test: true}]})
    assert status == :ok
  end

  test "get event collection schemas", %{bypass: bypass} do
    Bypass.expect_once(bypass, "GET", "/projects/project_id/events", fn conn ->
      Conn.resp(
        conn,
        200,
        "[{\"url\": \"/3.0/projects/project_id/events/da.opened\", \"name\": \"da.opened\", \"properties\": {\"serial\": \"string\", \"version\": \"string\", \"keen.timestamp\": \"datetime\", \"keen.created_at\": \"datetime\", \"keen.id\": \"string\"}}, {\"url\": \"/3.0/projects/project_id/events/dataalchemy\", \"name\": \"dataalchemy\", \"properties\": {\"ip_geo_info.country\": \"null\", \"parsed_user_agent.os.major\": \"null\", \"parsed_user_agent.browser.minor\": \"string\", \"serial\": \"string\", \"parsed_user_agent.browser.patch\": \"null\", \"keen.created_at\": \"datetime\", \"parsed_user_agent.os.minor\": \"null\", \"version\": \"string\", \"parsed_user_agent.browser.major\": \"string\", \"parsed_user_agent.os.family\": \"string\", \"parsed_user_agent.os.patch\": \"null\", \"ip_geo_info.province\": \"null\", \"parsed_user_agent.device.family\": \"string\", \"keen.id\": \"string\", \"ip_geo_info.continent\": \"null\", \"keen.timestamp\": \"datetime\", \"parsed_user_agent.browser.family\": \"string\", \"ip_address\": \"string\", \"ip_geo_info.city\": \"null\", \"parsed_user_agent.os.patch_minor\": \"null\", \"user_agent\": \"string\", \"ip_geo_info.postal_code\": \"null\"}}, {\"url\": \"/3.0/projects/project_id/events/dinner.tacos\", \"name\": \"dinner.tacos\", \"properties\": {\"test\": \"string\", \"keen.timestamp\": \"datetime\", \"keen.created_at\": \"datetime\", \"keen.id\": \"string\"}}, {\"url\": \"/3.0/projects/project_id/events/start\", \"name\": \"start\", \"properties\": {\"keen.created_at\": \"datetime\", \"repo_basename\": \"string\", \"repo_user\": \"string\", \"keen.id\": \"string\", \"url\": \"string\", \"host\": \"string\", \"keen.timestamp\": \"datetime\"}}, {\"url\": \"/3.0/projects/project_id/events/tacos\", \"name\": \"tacos\", \"properties\": {\"test\": \"bool\", \"keen.timestamp\": \"datetime\", \"keen.created_at\": \"datetime\", \"keen.id\": \"string\"}}]"
      )
    end)

    {status, _} = Keenex.inspect_all()
    assert status == :ok
  end
end
