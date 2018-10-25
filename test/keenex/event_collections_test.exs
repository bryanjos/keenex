defmodule Keenex.EventCollections.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Keenex.Helpers

  setup_all do
    Helpers.exvcr_setup()
    {:ok, []}
  end

  test "post new start event" do
    use_cassette "event collection multiple data" do
      data = %{
        url: "https://github.com/azukiapp/azk",
        host: "github.com",
        repo_user: "azukiapp",
        repo_basename: "azk"
      }

      {status, _} = Keenex.add_event("start", data)
      assert status == :ok
    end
  end

  test "get event collection schema" do
    use_cassette "event collection get schema" do
      {status, _} = Keenex.inspect("start")
      assert status == :ok
    end
  end
end
