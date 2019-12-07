defmodule ThxCore.IO.SensorReaderBehaviour do
  @callback read_temp(String.t) :: float()
  @callback read_temp(String.t, String.t) :: float()
end

defmodule ThxCore.IO.SensorReader do
  @behaviour ThxCore.IO.SensorReaderBehaviour
  require Logger

  @base_dir "/sys/bus/w1/devices/"

  def read_all_temp do
    File.ls!(@base_dir)
      |> Enum.filter(&(String.starts_with?(&1, "28-")))
      |> Enum.each(&read_temp(&1, @base_dir))
  end

  @impl ThxCore.IO.SensorReaderBehaviour
  def read_temp(sensor, base_dir \\ @base_dir) do
    sensor_data = File.read!("#{base_dir}#{sensor}/w1_slave")
    Logger.debug("reading sensor: #{sensor}: #{sensor_data}")
    {temp, _} = Regex.run(~r/t=(\d+)/, sensor_data)
    |> List.last
    |> Float.parse
    Logger.debug("Sensor: #{sensor} Temp: #{temp}")
    temp / 1000
  end

end

defmodule ThxCore.IO.FakeSensorReader do
  @behaviour ThxCore.IO.SensorReaderBehaviour

  @impl ThxCore.IO.SensorReaderBehaviour
  def read_temp(_sensor), do: 42.0
  @impl ThxCore.IO.SensorReaderBehaviour
  def read_temp(_sensor, _dir), do: 42.0

end

