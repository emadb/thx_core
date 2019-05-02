defmodule ThxCore.SensorProcess do
  use GenServer

  def init(name) do
    {:ok, %{name: name}}
  end

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: via_tuple(name))
  end

  defp via_tuple(name) do
    {:via, Registry, {ThxCore.SensorRegistry, name}}
  end
end
