defmodule Keenex.Events do
  alias Keenex.Base

  @doc """
  Inserts multiple events into one or more event collections

  
  ```
  Keenex.Events.post(keen, %{event_collection1: [%{data: "data"}], event_collection2: [%{data: "data"}, %{more_data: "data"}]})
  ```
  """
  @spec post(pid, map) :: Keenex.response
  def post(keen, events) do
    project_id = Keenex.project_id(keen)
    Base.post(keen, :write, "projects/#{project_id}/events", events)
  end
end