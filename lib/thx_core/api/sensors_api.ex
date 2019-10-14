defmodule ThxCore.Api.SensorsRouter do
  use Plug.Router

  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:match)
  plug(:dispatch)


  get "/" do
    sensors = ThxCore.Schema.Sensor |> ThxCore.Repo.all() |> Enum.map(&project_sensor/1)
    send_resp(conn, 200, encode(sensors))
  end

  get "/:id" do
    {sid, ""} = Integer.parse(id)
    sensor = ThxCore.Schema.Sensor |> ThxCore.Repo.get_by(id: sid) |> project_sensor
    send_resp(conn, 200, encode(sensor))
  end

  get "/:id/schedule" do
    {sid, ""} = Integer.parse(id)
    schedule = ThxCore.Schema.Schedule |> ThxCore.Repo.get_by(sensor_id: sid) |> project_schedule
    send_resp(conn, 200, encode(schedule))
  end

  defp project_sensor(s) do
    %{
      id: s.id,
      name: s.name,
      description: s.description,
      gpio: s.gpio,
    }
  end

  def project_schedule(s) do
    %{
      id: s.id,
      sensor_id: s.sensor_id,
      weekday: s.weekday,
      temperature: s.temperature
    }
  end

  defp encode(data) do
    Poison.encode!(data)
  end

end
