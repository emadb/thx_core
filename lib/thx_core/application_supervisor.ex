defmodule ThxCore.ApplicationSupervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = ThxData.Schema.Sensor
      |> ThxData.Repo.all
      |> Enum.map(fn s ->
        %{
          id: "supervisor_#{s.name}",
          start: {ThxCore.SensorSupervisor, :start_link, [[s.id, s.name, s.description, s.gpio]]}
        }
      end)

    Supervisor.init(children, strategy: :one_for_one)
  end
end


