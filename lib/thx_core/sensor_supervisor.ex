defmodule ThxCore.SensorSupervisor do
  use Supervisor

  @gpio_proxy Application.get_env(:thx_core, :gpio_proxy)

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)
  end

  def init([id, name, description, gpio]) do

    children = [%{
      id: "sensor_#{name}",
      start: {ThxCore.SensorProcess, :start_link, [name, description]}
    }, %{
      id: "writer_#{name}",
      start: {ThxCore.TemperatureWriter, :start_link, [id, name]}
    }, %{
      id: "scheduler_#{name}",
      start: {ThxCore.ScheduleProcess, :start_link, [id, name]}
    }, %{
      id: "gpio_#{name}",
      start: {@gpio_proxy, :start_link, [name, gpio]}
    }]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
