defmodule ThxCore.SensorProcess do
  use GenServer

  @reading_interval 10000
  @sensor_reader Application.get_env(:thx_core, :sensor_reader)


  def init([name, description]) do
    Process.send_after(self(), :get_temperature_scheduled, @reading_interval)
    {:ok, %{name: name, description: description}}

  end

  @spec start_link(any(), any()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(name, description) do
    GenServer.start_link(__MODULE__, [name, description], name: via_tuple(name))
  end

  defp via_tuple(name) do
    {:via, Registry, {ThxCore.SensorRegistry, name}}
  end

  def get_temperature(name) do
    GenServer.call(via_tuple(name), :get_temperature)
  end

  def handle_call(:get_temperature, _from, state) do
    temp = @sensor_reader.read_temp(state.name)
    {:reply, {:ok, temp}, state}
  end

  def handle_info(:get_temperature_scheduled, state) do
    temp = @sensor_reader.read_temp(state.name)
    ThxCore.TemperatureWriter.write_temperature(state.name, temp)
    ThxCore.ScheduleProcess.update_thermostat(state.name, temp)
    Process.send_after(self(), :get_temperature_scheduled, @reading_interval)
    {:noreply, state}
  end
end
