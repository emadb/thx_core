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
      ThxCore.Repo,
      {ThxCore.ApplicationSupervisor, []},
      {Plug.Cowboy, scheme: :http, plug: ThxCore.Api.Router, options: [port: 8000]}
      # Plug.Adapters.Cowboy.child_spec(:http, ThxCore.Api.Router, [], port: 8000, dispatch: dispatch()),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ThxCore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
       [
        # {"/ws", Rover.Web.WsServer, []},
         {:_, Plug.Adapters.Cowboy.Handler, {ThxCore.Api.Router, []}}
       ]}
    ]
  end
end
