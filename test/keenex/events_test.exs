defmodule Keenex.Events.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Keenex.Helpers

  setup_all do
    Helpers.exvcr_setup
    {:ok, keen } = Helpers.new_keenex
    {:ok, [keen: keen] }
  end

  test "post events" do
    use_cassette "events_post" do
      {status, _response} = Keenex.Events.post(%{tacos: [%{test: true}]})
      assert status == :ok
    end
  end

  test "get event collection schemas" do
    use_cassette "event collection get schemas" do
      {status, _} = Keenex.Events.get()
      assert status == :ok
    end
  end
end
