defmodule ThxCore.TemperatureWriter do
  use GenServer

  def init([id, name]) do
    {:ok, %{id: id, name: name}}
  end

  def start_link(id, name) do
    GenServer.start_link(__MODULE__, [id, name], name: via_tuple(name))
  end

  defp via_tuple(name) do
    {:via, Registry, {ThxCore.TemperatureWriterRegistry, "writer_#{name}"}}
  end

  def write_temperature(name, temperature) do
    GenServer.call(via_tuple(name), {:write_temperature, temperature})
  end

  def handle_call({:write_temperature, temperature}, _from, state) do

    value = %ThxData.Schema.Temperature{
      sensor_id: state.id,
      date: DateTime.utc_now,
      value: temperature
    }
    ThxData.Repo.insert(value)
    {:reply, :ok, state}
  end
end
