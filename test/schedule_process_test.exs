defmodule ThxCore.ScheduleProcessTest do
  use ExUnit.Case
  use ThxCore.RepoCase
  import Mox


  setup :set_mox_global
  setup :verify_on_exit!

  test "Temperature goes under threshold, thermostat should switch on" do

    Test.ThermostatWriterMock
    |> expect(:switch_on, 1, fn _ -> :ok end)
    |> expect(:switch_off, 0, fn _ -> :ok end)

    ThxCore.ScheduleProcess.start_link(1, "one")
    ThxCore.ScheduleProcess.update_thermostat("one", 5)
  end

  test "Temperature is over threshold, thermostat should do nothing" do

    Test.ThermostatWriterMock
    |> expect(:switch_on, 0, fn _ -> :ok end)
    |> expect(:switch_off, 1, fn _ -> :ok end)

    ThxCore.ScheduleProcess.start_link(1, "one")
    ThxCore.ScheduleProcess.update_thermostat("one", 25)
  end
end
