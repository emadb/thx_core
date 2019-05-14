defmodule ThxCore.ScheduleProcessTest do
  use ExUnit.Case
  use ThxCore.RepoCase
  import Mox



  setup :verify_on_exit!

  test "Temperature goes under threshold, thermostat should switch on" do

    Test.ThermostatWriterMock
    |> expect(:switch_on, fn _ -> :ok end)

    ## TODO: 1 is not always valid, we need to query the database to know the id??
    ThxCore.ScheduleProcess.start_link(1, "one")
    IO.inspect ThxCore.ScheduleProcess.get_schedule("one"), label: "Schedule>>>"
  end
end
