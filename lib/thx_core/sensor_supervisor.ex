defmodule ThxCore.SensorSupervisor do
  use Supervisor
  # @gpio ElixirALE.GPIO
  @gpio FakeGpio

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
            start: {@gpio, :start_link, [gpio, :output]}
          }
        ]
      Supervisor.init(children, strategy: :one_for_one)
  end
end


defmodule FakeGpio do
  use GenServer

  def init(_), do: {:ok, []}

  def start_link(port, direction) do
    GenServer.start_link(__MODULE__, [port, direction])
  end
end
