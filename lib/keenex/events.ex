defmodule Keenex.Events do
  alias Keenex.HTTP

  @doc """
  Return schema information for all the event collections in a given project, along with properties (and their types), and links to sub-resources.


  ```
  Keenex.Events.get()
  ```
  """
  @spec get() :: Keenex.response
  def get() do
    HTTP.get("/projects/#{Keenex.project_id}/events")
  end

  @doc """
  Record multiple events to one or more event collections with a single request.


  ```
  Keenex.Events.post(%{event_collection1: [%{data: "data"}], event_collection2: [%{data: "data"}, %{more_data: "data"}]})
  ```
  """
  @spec post(map) :: Keenex.response
  def post(events) do
    HTTP.post("/projects/#{Keenex.project_id}/events", events)
  end
end
