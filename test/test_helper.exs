defmodule Keenex.Helpers do
  
  def exvcr_setup do
    ExVCR.Config.cassette_library_dir(cassette_dir)
    ExVCR.Config.filter_sensitive_data(project_id, "project_id")
    ExVCR.Config.filter_sensitive_data(write_key, "write_key")
    ExVCR.Config.filter_sensitive_data(read_key, "read_key")
    HTTPotion.start
  end

  def new_keenex do
    Keenex.start_link(project_id, write_key, read_key)
  end

  def cassette_dir do
    "fixture/cassettes"
  end

  def project_id do
    Application.get_env(:keen, :project_id, System.get_env("KEEN_PROJECT_ID"))
  end

  def write_key do
    Application.get_env(:keen, :write_key, System.get_env("KEEN_WRITE_KEY"))
  end

  def read_key do
    Application.get_env(:keen, :read_key, System.get_env("KEEN_READ_KEY"))
  end

end


ExUnit.start()
