defmodule Keenex.Events.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Keenex.Helpers

  setup_all do
    Helpers.exvcr_setup()
    {:ok, []}
  end

  test "post events" do
    use_cassette "events_post" do
      {status, _response} = Keenex.add_events(%{tacos: [%{test: true}]})
      assert status == :ok
    end
  end

  test "get event collection schemas" do
    use_cassette "event collection get schemas" do
      {status, _} = Keenex.inspect_all()
      assert status == :ok
    end
  end
end
