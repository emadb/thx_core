defmodule ThxCore.SensorSupervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do

    children = ThxCore.Schema.Sensor
      |> ThxCore.Repo.all
      |> Enum.map(fn s ->
        [%{
          id: "sensor_#{s.name}",
          start: {ThxCore.SensorProcess, :start_link, [s.name, s.description]}
        }, %{
          id: "writer_#{s.name}",
          start: {ThxCore.TemperatureWriter, :start_link, [s.id, s.name]}
        },]
      end)
      |> Enum.flat_map(&(&1))

    Supervisor.init(children, strategy: :one_for_one)
  end
end
