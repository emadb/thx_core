defmodule ThxCore.Api.Router do
  use Plug.Router

  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  # plug(Plug.Static, at: "/", from: "priv/static")
  plug(:match)
  plug(:dispatch)


  get "/ping" do
    send_resp(conn, 200, encode(%{message: "pong"}))
  end

  forward "/sensors", to: ThxCore.Api.SensorsRouter

  defp encode(data) do
    Poison.encode!(data)
  end

  match(_) do
    send_resp(conn, 404, "")
  end
end
