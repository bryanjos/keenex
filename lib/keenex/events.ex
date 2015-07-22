defmodule Keenex.Events do
  alias Keenex.Base

  @doc """
  Inserts multiple events into one or more event collections


  ```
  Keenex.Events.post(%{event_collection1: [%{data: "data"}], event_collection2: [%{data: "data"}, %{more_data: "data"}]})
  ```
  """
  @spec post(map) :: Keenex.response
  def post(events) do
    Base.post("events", events)
  end
end
