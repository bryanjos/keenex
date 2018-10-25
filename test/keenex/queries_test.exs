defmodule Keenex.Queries.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Keenex.Helpers

  setup_all do
    Helpers.exvcr_setup()
    {:ok, []}
  end

  test "count" do
    use_cassette "analysis:count" do
      data = %{
        timeframe: "this_7_days"
      }

      {status, _} = Keenex.count("start", data)
      assert status == :ok
    end
  end

  test "count: only required" do
    use_cassette "analysis:count_only_required" do
      {status, _} = Keenex.count("start")
      assert status == :ok
    end
  end

  test "count_unique" do
    use_cassette "analysis:count_unique" do
      {status, _} = Keenex.count_unique("start", "host")
      assert status == :ok
    end
  end

  test "minimum" do
    use_cassette "analysis:minimum" do
      {status, _} = Keenex.minimum("start", "host")
      assert status == :ok
    end
  end

  test "maximum" do
    use_cassette "analysis:maximum" do
      {status, _} = Keenex.maximum("start", "host")
      assert status == :ok
    end
  end

  test "sum" do
    use_cassette "analysis:sum" do
      {status, _} = Keenex.sum("start", "host")
      assert status == :ok
    end
  end

  test "average" do
    use_cassette "analysis:average" do
      {status, _} = Keenex.average("start", "host")
      assert status == :ok
    end
  end

  test "median" do
    use_cassette "analysis:median" do
      {status, _} = Keenex.median("start", "host")
      assert status == :ok
    end
  end

  test "percentile" do
    use_cassette "analysis:percentile" do
      {status, _} = Keenex.percentile("start", "host", 10)
      assert status == :ok
    end
  end

  test "select_unique" do
    use_cassette "analysis:select_unique" do
      {status, _} = Keenex.select_unique("start", "host")
      assert status == :ok
    end
  end

  test "multi_analysis" do
    use_cassette "analysis:multi_analysis" do
      analyses = %{
        sum: %{
          analysis_type: "sum",
          target_property: "host"
        },
        median: %{
          analysis_type: "median",
          target_property: "host"
        }
      }

      {status, _} = Keenex.multi_analysis("start", analyses)
      assert status == :ok
    end
  end

  test "funnel" do
    use_cassette "analysis:funnel" do
      steps = [
        %{
          event_collection: "start",
          actor_property: "host",
          timeframe: "this_7_days"
        }
      ]

      {status, _} = Keenex.funnel(steps)
      assert status == :ok
    end
  end

  test "extraction" do
    use_cassette "analysis:extraction" do
      {status, _} = Keenex.extraction("start")
      assert status == :ok
    end
  end
end
