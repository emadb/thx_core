defmodule ThxCore.GpioProxy do
  use GenServer
  @gpio FakeGpio
  # @gpio ElixirALE.GPIO

  def init([name, port]) do
    {:ok, pid} = @gpio.start_link(port, :output)
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
    @gpio.write(pid, 1)
    {:reply, :ok, state}
  end

  def handle_call(:write_off, _from, state = %{pid: pid}) do
    @gpio.write(pid, 0)
    {:reply, :ok, state}
  end

end


defmodule FakeGpio do
  use GenServer

  def init(_), do: {:ok, []}

  def start_link(port, direction) do
    GenServer.start_link(__MODULE__, [port, direction], name: String.to_atom(Integer.to_string(port)))
  end

  def write(_), do: :ok
end
