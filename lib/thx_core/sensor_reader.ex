defmodule ThxCore.SensorReader do

  require Logger

  @base_dir "/sys/bus/w1/devices/"

  def read_all_temp do
    File.ls!(@base_dir)
      |> Enum.filter(&(String.starts_with?(&1, "28-")))
      |> Enum.each(&read_temp(&1, @base_dir))
  end

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
