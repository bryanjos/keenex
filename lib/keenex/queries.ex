defmodule Keenex.Queries do
  def count(data) do
    query("count", data)
  end

  def count_unique(data) do
    query("count_unique", data)
  end

  def minimum(data) do
    query("minimum", data)
  end

  def maximum(data) do
    query("maximum", data)
  end

  def average(data) do
    query("average", data)
  end

  def median(data) do
    query("median", data)
  end

  def select_unique(data) do
    query("select_unique", data)
  end

  def multi_analysis(data) do
    query("multi_analysis", data)
  end

  def extraction(data) do
    query("extraction", data)
  end

  def funnel(data) do
    query("funnel", data)
  end

  defp query(type, data) do
    HTTP.post("/projects/#{Keenex.project_id}/queries/#{type}", data, :read)
  end
end
