defmodule Keenex.Queries.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Keenex.Helpers

  setup_all do
    Helpers.exvcr_setup
    {:ok, keen } = Helpers.new_keenex
    {:ok, [keen: keen] }
  end

  test "count" do
    use_cassette "analysis:count" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days"
      }
      {status, _} = Keenex.Queries.count(data)
      assert status == :ok
    end
  end

  test "count: missing required fields" do
    use_cassette "analysis:count_missing_required" do
      data = %{
      }
      {status, _} = Keenex.Queries.count(data)
      assert status == :error
    end
  end

  test "count_unique" do
    use_cassette "analysis:count_unique" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days",
        target_property: "host"
      }
      {status, _} = Keenex.Queries.count_unique(data)
      assert status == :ok
    end
  end

  test "minimum" do
    use_cassette "analysis:minimum" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days",
        target_property: "host"
      }
      {status, _} = Keenex.Queries.minimum(data)
      assert status == :ok
    end
  end

  test "maximum" do
    use_cassette "analysis:maximum" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days",
        target_property: "host"

      }
      {status, _} = Keenex.Queries.maximum(data)
      assert status == :ok
    end
  end

  test "sum" do
    use_cassette "analysis:sum" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days",
        target_property: "host"

      }
      {status, _} = Keenex.Queries.sum(data)
      assert status == :ok
    end
  end

  test "average" do
    use_cassette "analysis:average" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days",
        target_property: "host"

      }
      {status, _} = Keenex.Queries.average(data)
      assert status == :ok
    end
  end

  test "median" do
    use_cassette "analysis:median" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days",
        target_property: "host"

      }
      {status, _} = Keenex.Queries.median(data)
      assert status == :ok
    end
  end

  test "percentile" do
    use_cassette "analysis:percentile" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days",
        target_property: "host",
        percentile: 10

      }
      {status, _} = Keenex.Queries.percentile(data)
      assert status == :ok
    end
  end

  test "select_unique" do
    use_cassette "analysis:select_unique" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days",
        target_property: "host"

      }
      {status, _} = Keenex.Queries.select_unique(data)
      assert status == :ok
    end
  end

  test "multi_analysis" do
    use_cassette "analysis:multi_analysis" do
      data = %{
        event_collection: "start",
        analyses: %{
          sum: %{
            analysis_type: "sum",
            target_property: "host"
          },
          median: %{
            analysis_type: "median",
            target_property: "host"
          }
        },
        timeframe: "this_7_days"
      }
      {status, _} = Keenex.Queries.multi_analysis(data)
      assert status == :ok
    end
  end

  test "funnel" do
    use_cassette "analysis:funnel" do
      data = %{
        steps: [
          %{
            event_collection: "start",
            actor_property: "host",
            timeframe: "this_7_days"
          }
        ]
      }
      {status, _} = Keenex.Queries.funnel(data)
      assert status == :ok
    end
  end

  test "extraction" do
    use_cassette "analysis:extraction" do
      data = %{
        event_collection: "start",
        timeframe: "this_7_days"
      }
      {status, _} = Keenex.Queries.extraction(data)
      assert status == :ok
    end
  end


end
