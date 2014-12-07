defmodule Keenex do
  use GenServer

  @type status :: :ok | :error
  @type response :: {status, map}

  defmodule Config do
    @type t :: %Config{ project_id: binary, write_key: binary, read_key: binary }
    defstruct [:project_id, :write_key, :read_key]
  end

  @moduledoc """
  This module defines the Keenex API. Use it as follows

  looks for application variables in the `:keen` app named `:project_id`, `:write_key`, `:read_key`
  or if any of those aren't available, it looks for environment variables named `KEEN_PROJECT_ID`, `KEEN_WRITE_KEY`, `KEEN_READ_KEY`

  ```
  {:ok, keen} = Keenex.new
  ```

  alternatively, you can pass in the variables as well

  ```
  {:ok, keen} = Keenex.new("keen_project_id", "keen_write_key", "keen_read_key") 
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
  Starts new Keenex config process with the given project_id, write_key, and read_key
  """
  @spec new(binary, binary, binary) :: { Keenex.status, pid }
  def new(project_id, write_key, read_key) do
    start_link(%Config{project_id: project_id, write_key: write_key, read_key: read_key})
  end

  @doc """
  Starts new Keenex config process.
  
  Looks for application variables in the `:keen` app named `:project_id`, `:write_key`, `:read_key`
  or if any of those aren't available, it looks for environment variables named `KEEN_PROJECT_ID`, `KEEN_WRITE_KEY`, `KEEN_READ_KEY`
  """
  @spec new() :: { Keenex.status, pid }
  def new() do
    project_id = Application.get_env(:keen, :project_id, System.get_env("KEEN_PROJECT_ID"))
    write_key =  Application.get_env(:keen, :write_key, System.get_env("KEEN_WRITE_KEY"))
    read_key =  Application.get_env(:keen, :read_key, System.get_env("KEEN_READ_KEY"))

    new(project_id, write_key, read_key)
  end


  @spec start_link(Keenex.Config.t) :: { Keenex.status, pid }
  def start_link(config) do
    GenServer.start_link(__MODULE__, config)
  end

  @doc """
  Returns the project id
  """
  @spec project_id(pid) :: binary
  def project_id(keen) do
    config(keen).project_id
  end

  @doc """
  Returns the write key
  """
  @spec write_key(pid) :: binary
  def write_key(keen) do
    config(keen).write_key
  end

  @doc """
  Returns the read key
  """
  @spec read_key(pid) :: binary
  def read_key(keen) do
    config(keen).read_key
  end

  @doc """
  Returns the entire config struct
  """
  @spec config(pid) :: Keenex.Config.t
  def config(keen) do
    GenServer.call(keen, :get_configuration)
  end

  def init(config) do
    {:ok, config}
  end

  @doc false
  def handle_call(:get_configuration, _from, config) do
    {:reply, config, config}
  end
end
