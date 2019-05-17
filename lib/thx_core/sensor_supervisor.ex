defmodule ThxCore.SensorSupervisor do
  use Supervisor

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
      start: {ThxCore.GpioProxy, :start_link, [name, gpio]}
    }]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
