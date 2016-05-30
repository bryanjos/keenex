defmodule Keenex do
  alias Keenex.HTTP

  @type status :: :ok | :error
  @type response :: {status, map}

  @moduledoc """
  This module defines the Keenex API

  looks for application variables in the `:keen` app named `:project_id`, `:write_key`, `:read_key`
  or if any of those aren't available, it looks for environment variables named `KEEN_PROJECT_ID`, `KEEN_WRITE_KEY`, `KEEN_READ_KEY`

  Add it to your applications:


      def application do
          [applications: [:keenex]]
      end

  Or call start_link directly either using `start_link\0` or `start_link\3` to pass in variables


      {:ok, keen} = Keenex.start_link

      # OR

      {:ok, keen} = Keenex.start_link("keen_project_id", "keen_write_key", "keen_read_key")


  and then call functions

      {status, response} = Keenex.add_event("dinner.tacos", %{test: "tacos"})


  status is either `:ok` or `:error`

  response is a Map converted from the json response from Keen.

  Info about the contents can be found [here](https://keen.io/docs/api/)
  """

  @doc """
  Starts Keenex app with the given project_id, write_key, and read_key
  """
  @spec start_link(binary, binary, binary) :: { Keenex.status, pid }
  def start_link(project_id, write_key, read_key) do
    config = %{project_id: project_id, write_key: write_key, read_key: read_key}
    Agent.start_link(fn -> config end, name: __MODULE__)
  end

  @doc """
  Starts Keenex app.

  Looks for application variables in the `:keen` app named `:project_id`, `:write_key`, `:read_key`
  or if any of those aren't available, it looks for environment variables named `KEEN_PROJECT_ID`, `KEEN_WRITE_KEY`, `KEEN_READ_KEY`
  """
  @spec start_link() :: { Keenex.status, pid }
  def start_link() do
    project_id = Application.get_env(:keen, :project_id, System.get_env("KEEN_PROJECT_ID"))
    write_key  = Application.get_env(:keen, :write_key , System.get_env("KEEN_WRITE_KEY" ))
    read_key   = Application.get_env(:keen, :read_key  , System.get_env("KEEN_READ_KEY"  ))

    start_link(project_id, write_key, read_key)
  end

  @doc """
  Returns schema for a single event collection


  ```
  Keenex.inspect("dinner.tacos")
  ```
  """
  @spec inspect(binary) :: Keenex.response
  def inspect(event_collection) do
    HTTP.get("/projects/#{HTTP.project_id}/events/#{event_collection}")
  end

  @doc """
  Returns schema for all event collections


  ```
  Keenex.inspect_all()
  ```
  """
  @spec inspect_all() :: Keenex.response
  def inspect_all() do
    HTTP.get("/projects/#{HTTP.project_id}/events")
  end


  @doc """
  Publishes an event into the event collection


  ```
  Keenex.add_event("dinner.tacos", %{data: "data"})
  ```
  """
  @spec add_event(binary, map) :: Keenex.response
  def add_event(event_collection, data) do
    HTTP.post("/projects/#{HTTP.project_id}/events/#{event_collection}", data)
  end


  @doc """
  Publishes multiple events to one or more event collections


  ```
  Keenex.add_events(%{event_collection1: [%{data: "data"}], event_collection2: [%{data: "data"}, %{more_data: "data"}]})
  ```
  """
  @spec add_events(map) :: Keenex.response
  def add_events(events) do
    HTTP.post("/projects/#{HTTP.project_id}/events", events)
  end

  @doc """
  Returns the number of events in a collection matching the given criteria
  """
  @spec count(binary, map) :: Keenex.response
  def count(event_collection, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection}, params)
    query("count", params)
  end

  @doc """
  Return the number of events with unique values, for a target property in a collection matching given criteria
  """
  @spec count_unique(binary, binary, map) :: Keenex.response
  def count_unique(event_collection, target_property, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection, target_property: target_property}, params)
    query("count_unique", params)
  end

  @doc """
  Return the minimum numeric value for a target property, among all events in a collection matching given criteria.
  """
  @spec minimum(binary, binary, map) :: Keenex.response
  def minimum(event_collection, target_property, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection, target_property: target_property}, params)
    query("minimum", params)
  end

  @doc """
  Return the maximum numeric value for a target property, among all events in a collection matching given criteria.
  """
  @spec maximum(binary, binary, map) :: Keenex.response
  def maximum(event_collection, target_property, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection, target_property: target_property}, params)
    query("maximum", params)
  end

  @doc """
  Calculate the sum of all numeric values for a target property, among all events in a collection matching given criteria.
  """
  @spec sum(binary, binary, map) :: Keenex.response
  def sum(event_collection, target_property, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection, target_property: target_property}, params)
    query("sum", params)
  end

  @doc """
  Calculate the average value for a target property, among all events in a collection matching given criteria.
  """
  @spec average(binary, binary, map) :: Keenex.response
  def average(event_collection, target_property, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection, target_property: target_property}, params)
    query("average", params)
  end

  @doc """
  Calculate the median value for a target property, among all events in a collection matching given criteria.
  """
  @spec median(binary, binary, map) :: Keenex.response
  def median(event_collection, target_property, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection, target_property: target_property}, params)
    query("median", params)
  end

  @doc """
  Calculate a specified percentile value for a target property, among all events in a collection matching given criteria.
  """
  @spec percentile(binary, binary, integer, map) :: Keenex.response
  def percentile(event_collection, target_property, percentile, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection, target_property: target_property, percentile: percentile}, params)
    query("percentile", params)
  end

  @doc """
  Return a list of unique property values for a target property, among all events in a collection matching given criteria.
  """
  @spec select_unique(binary, binary, map) :: Keenex.response
  def select_unique(event_collection, target_property, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection, target_property: target_property}, params)
    query("select_unique", params)
  end

  @doc """
  Runs multiple types of analyses over the same data
  """
  @spec multi_analysis(binary, map, map) :: Keenex.response
  def multi_analysis(event_collection, analyses, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection, analyses: analyses}, params)
    query("multi_analysis", params)
  end

  @doc """
  Creates an extraction request for full-form event data with all property values.
  """
  @spec extraction(binary, map) :: Keenex.response
  def extraction(event_collection, params \\ %{}) do
    params = Map.merge(%{event_collection: event_collection}, params)
    query("extraction", params)
  end

  @doc """
  Returns the number of unique actors that successfully (or unsuccessfully) make it through a series of steps
  """
  @spec funnel(list) :: Keenex.response
  def funnel(steps, params \\ %{}) do
    params = Map.merge(%{steps: steps}, params)
    query("funnel", params)
  end

  defp query(type, params) do
    HTTP.post("/projects/#{HTTP.project_id}/queries/#{type}", params, :read)
  end


end
