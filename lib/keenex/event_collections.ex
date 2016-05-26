defmodule Keenex.EventCollections do
  alias Keenex.HTTP

  @doc """
  Returns schema information for a single event collection,


  ```
  Keenex.EventCollections.get("dinner.tacos")
  ```
  """
  @spec get(binary) :: Keenex.response
  def get(collection) do
    HTTP.get("/projects/#{Keenex.project_id}/events/#{collection}")
  end


  @doc """
  Inserts an event into the event collection


  ```
  Keenex.EventCollections.post("dinner.tacos", %{data: "data"})
  ```
  """
  @spec post(binary, map) :: Keenex.response
  def post(collection, data) do
    HTTP.post("/projects/#{Keenex.project_id}/events/#{collection}", data)
  end
end
