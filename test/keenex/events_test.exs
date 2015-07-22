defmodule Keenex.Events.Test do
  use ExUnit.Case, async: false

  # use ExVCR.Mock
  alias Keenex.Helpers

  setup_all do
    Helpers.exvcr_setup
    {:ok, keen } = Helpers.new_keenex
    {:ok, [keen: keen] }
  end

  # test "post events", context do
  #   use_cassette "events_post" do
  #     {status, _response} = Keenex.Events.post(%{tacos: [%{test: true}]})
  #     assert status == :ok
  #   end
  # end
end
