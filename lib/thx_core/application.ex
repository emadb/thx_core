defmodule ThxCore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Registry, [keys: :unique, name: ThxCore.SensorRegistry]},
      {Registry, [keys: :unique, name: ThxCore.TemperatureWriterRegistry]},
      {Registry, [keys: :unique, name: ThxCore.TemperatureScheduleRegistry]},
      {Registry, [keys: :unique, name: ThxCore.GpioRegistry]},
      # {Postgrex, Keyword.put(Application.get_env(:thx_core, :db), :name, DB)},
      # ThxData.Repo,
      {ThxCore.ApplicationSupervisor, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ThxCore.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
