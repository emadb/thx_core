defmodule ThxCore.SensorSupervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      %{
        id: "28-100",
        start: {ThxCore.SensorProcess, :start_link, ["28-100"]}
      },
      %{
        id: "28-200",
        start: {ThxCore.SensorProcess, :start_link, ["28-200"]}
      },
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
