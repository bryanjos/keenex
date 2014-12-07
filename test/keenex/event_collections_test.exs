defmodule Keenex.EventCollections.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock
  alias Keenex.Helpers

  setup_all do
    Helpers.exvcr_setup
    {:ok, keen } = Helpers.new_keenex
    {:ok, [keen: keen] }
  end

  test "post to event collection", context do
    use_cassette "event_collections_post" do
      {status, response} = Keenex.EventCollections.post(context[:keen], "dinner.tacos", %{test: "tacos"})
      assert status == :ok
    end
  end
end