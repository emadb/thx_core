defmodule ThxCore.SensorProcessTest do
  use ExUnit.Case

  test "get_temperature should return 42" do
    ThxCore.SensorProcess.start_link("foo", "bar")
    {:ok, temp} = ThxCore.SensorProcess.get_temperature("foo")
    assert temp == 42
  end
end
