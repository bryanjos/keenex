defmodule Keenex do

  @type status :: :ok | :error
  @type response :: {status, map}

  defmodule Config do
    @type t :: %Config{ project_id: binary, write_key: binary, read_key: binary }
    defstruct [:project_id, :write_key, :read_key, :master_key]
  end

  @moduledoc """
  This module defines the Keenex API. Use it as follows

  looks for application variables in the `:keen` app named `:project_id`, `:write_key`, `:read_key`, `:master_key`
  or if any of those aren't available, it looks for environment variables named `KEEN_PROJECT_ID`, `KEEN_WRITE_KEY`, `KEEN_READ_KEY`, `MASTER_KEY`

  ```
  {:ok, keen} = Keenex.start_link
  ```

  alternatively, you can pass in the variables as well

  ```
  {:ok, keen} = Keenex.start_link("keen_project_id", "keen_write_key", "keen_read_key", "master_key")
  ```
  then pass in the keen pid when calling functions

  ```
  {status, response} = Keenex.EventCollections.post(keen, "dinner.tacos", %{test: "tacos"})
  ```
  status is either :ok or :error

  response is a Map converted from the json response from Keen.

  Info about the contents can be found [here](https://keen.io/docs/api/reference/)
  """

  @doc """
  Starts Keenex process with the given project_id, write_key, read_key, and master_key
  """
  @spec start_link(binary, binary, binary, binary) :: { Keenex.status, pid }
  def start_link(project_id, write_key, read_key, master_key) do
    %Config{project_id: project_id, write_key: write_key, read_key: read_key, master_key: master_key}
    |> start_link
  end

  @doc """
  Starts start_link Keenex config process.

  Looks for application variables in the `:keen` app named `:project_id`, `:write_key`, `:read_key`, `:master_key`
  or if any of those aren't available, it looks for environment variables named `KEEN_PROJECT_ID`, `KEEN_WRITE_KEY`, `KEEN_READ_KEY`, `KEEN_MASTER_KEY`
  """
  @spec start_link() :: { Keenex.status, pid }
  def start_link() do
    project_id = Application.get_env(:keen, :project_id, System.get_env("KEEN_PROJECT_ID"))
    write_key  = Application.get_env(:keen, :write_key , System.get_env("KEEN_WRITE_KEY" ))
    read_key   = Application.get_env(:keen, :read_key  , System.get_env("KEEN_READ_KEY"  ))
    master_key = Application.get_env(:keen, :master_key, System.get_env("KEEN_MASTER_KEY"))

    start_link(project_id, write_key, read_key, master_key)
  end


  @spec start_link(Keenex.Config.t) :: { Keenex.status, pid }
  def start_link(config) do
    Agent.start_link(fn -> config end, name: __MODULE__)
  end

  @doc """
  Returns the project id
  """
  @spec project_id() :: binary
  def project_id() do
    config().project_id
  end

  @doc """
  Returns the write key
  """
  @spec write_key() :: binary
  def write_key() do
    config().write_key
  end

  @doc """
  Returns the read key
  """
  @spec read_key() :: binary
  def read_key() do
    config().read_key
  end

  @doc """
  Returns the read key
  """
  @spec master_key() :: binary
  def master_key() do
    config().master_key
  end

  defp config() do
    Agent.get(__MODULE__, fn(state) -> state end)
  end

end
