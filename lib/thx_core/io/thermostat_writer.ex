defmodule ThxCore.IO.ThermostatWriterBehaviour do
  @callback switch_on(String.t) :: :ok
  @callback switch_off(String.t) :: :ok
end

defmodule ThxCore.IO.ThermostatWriter do
  @behaviour ThxCore.IO.ThermostatWriterBehaviour
  require Logger

  @impl ThxCore.IO.ThermostatWriterBehaviour
  def switch_on(sensor) do
    Logger.debug("Sensor: #{sensor} switch on")
    :ok
  end

  @impl ThxCore.IO.ThermostatWriterBehaviour
  def switch_off(sensor) do
    Logger.debug("Sensor: #{sensor} switch off")
    :ok
  end
end

defmodule ThxCore.IO.FakeThermostatWriter do
  @behaviour ThxCore.IO.ThermostatWriterBehaviour

  @impl ThxCore.IO.ThermostatWriterBehaviour
  def switch_on(_sensor), do: :ok
  @impl ThxCore.IO.ThermostatWriterBehaviour
  def switch_off(_sensor, _dir), do: :ok

end

