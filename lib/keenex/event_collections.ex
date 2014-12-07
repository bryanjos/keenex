defmodule Keenex.EventCollections do
  alias Keenex.Base

  @doc """
  Inserts an event into the event collection

  ```
  Keenex.EventCollections.post(keen, "dinner.tacos", %{data: "data"})
  ```
  """
  @spec post(pid, binary, map) :: Keenex.response
  def post(keen, event_collection, data) do
    project_id = Keenex.project_id(keen)
    Base.post(keen, :write, "projects/#{project_id}/events/#{event_collection}", data)
  end
end