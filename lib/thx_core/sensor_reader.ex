defmodule ThxCore.SensorReaderBehaviour do
  @callback read_temp(String.t) :: float()
  @callback read_temp(String.t, String.t) :: float()
end

defmodule ThxCore.SensorReader do
  @behaviour ThxCore.SensorReaderBehaviour
  require Logger

  @base_dir "/sys/bus/w1/devices/"

  def read_all_temp do
    File.ls!(@base_dir)
      |> Enum.filter(&(String.starts_with?(&1, "28-")))
      |> Enum.each(&read_temp(&1, @base_dir))
  end

  @impl ThxCore.SensorReaderBehaviour
  def read_temp(sensor, base_dir \\ @base_dir) do
    sensor_data = File.read!("#{base_dir}#{sensor}/w1_slave")
    Logger.debug("reading sensor: #{sensor}: #{sensor_data}")
    {temp, _} = Regex.run(~r/t=(\d+)/, sensor_data)
    |> List.last
    |> Float.parse
    Logger.debug("Sensor: #{sensor} Temp: #{temp}")
    temp
  end

end

defmodule ThxCore.FakeSensorReader do
  @behaviour ThxCore.SensorReaderBehaviour

  @impl ThxCore.SensorReaderBehaviour
  def read_temp(_sensor), do: 42.0
  @impl ThxCore.SensorReaderBehaviour
  def read_temp(_sensor, _dir), do: 42.0

end

