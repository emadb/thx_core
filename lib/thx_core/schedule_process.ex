defmodule ThxCore.ScheduleProcess do
  use GenServer
  import Ecto.Query, only: [from: 2]

  @gpio_proxy Application.get_env(:thx_core, :gpio_proxy)

  def init([id, name]) do
    schedule = ThxCore.Repo.all(from s in ThxCore.Schema.Schedule, where: s.sensor_id == ^id, select: {s.weekday, s.temperature})

    {:ok, %{id: id, name: name, schedule: schedule}}
  end

  def start_link(id, name) do
    GenServer.start_link(__MODULE__, [id, name], name: via_tuple(name))
  end

  defp via_tuple(name) do
    {:via, Registry, {ThxCore.TemperatureScheduleRegistry, "scheduler_#{name}"}}
  end

  def update_thermostat(name, temperature) do
    GenServer.call(via_tuple(name), {:update_thermostat, temperature})
  end

  def handle_call({:update_thermostat, temp}, _from, state) do

    {_, {h, _, _}} = :calendar.local_time()
    [{_, sch}] = state.schedule

    toggle_thermostat(temp, Enum.at(sch, h), state)
  end

  defp toggle_thermostat(temp, needed_temp, state) when temp > needed_temp do
    @gpio_proxy.write_off(state.name)
    {:reply, :nop, state}
  end

  defp toggle_thermostat(_temp, _needed_temp, state) do
    @gpio_proxy.write_on(state.name)
    {:reply, :on, state}
  end
end
