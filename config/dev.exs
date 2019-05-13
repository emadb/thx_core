use Mix.Config

config :thx_core, sensor_reader: ThxCore.IO.FakeSensorReader
config :thx_core, thermostat_writer: ThxCore.IO.FakeThermostatWriter
