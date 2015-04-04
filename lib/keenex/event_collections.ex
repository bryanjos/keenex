defmodule Keenex.EventCollections do
  alias Keenex.Base

  @doc """
  Inserts an event into the event collection

  ```
  Keenex.EventCollections.post("dinner.tacos", %{data: "data"})
  ```
  """
  @spec post(binary, map) :: Keenex.response
  def post(event_collection, data) do
    project_id = Keenex.project_id()
    Base.post(:write, "projects/#{project_id}/events/#{event_collection}", data)
  end
end