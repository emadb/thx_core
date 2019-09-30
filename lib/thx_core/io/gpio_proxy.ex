
defmodule ThxCore.GpioProxyBehaviour do
  @callback write_on(String.t) :: :ok
  @callback write_off(String.t) :: :ok
end


defmodule ThxCore.GpioProxy do
  use GenServer
  @behaviour ThxCore.GpioProxyBehaviour

  def init([name, port]) do
    {:ok, pid} = ElixirALE.GPIO.start_link(port, :output)
    {:ok, %{name: name, port: port, pid: pid}}
  end

  def start_link(name, port) do
    GenServer.start_link(__MODULE__, [name, port], name: via_tuple(name))
  end

  defp via_tuple(name) do
    {:via, Registry, {ThxCore.GpioRegistry, "gpio_#{name}"}}
  end

  def write_on(name) do
    GenServer.call(via_tuple(name), :write_on)
  end

  def write_off(name) do
    GenServer.call(via_tuple(name), :write_off)
  end

  def handle_call(:write_on, _from, state = %{pid: pid}) do
    ElixirALE.GPIO.write(pid, 1)
    {:reply, :ok, state}
  end

  def handle_call(:write_off, _from, state = %{pid: pid}) do
    ElixirALE.GPIO.write(pid, 0)
    {:reply, :ok, state}
  end

end


defmodule ThxCore.FakeGpioProxy do
  use GenServer
  @behaviour ThxCore.GpioProxyBehaviour

  def init(_), do: {:ok, []}

  def start_link(port, direction) do
    GenServer.start_link(__MODULE__, [port, direction], name: String.to_atom(port))
  end

  def write_on(_), do: :ok
  def write_off(_), do: :ok
end
