use Mix.Config

config :thx_core, sensor_reader: ThxCore.IO.FakeSensorReader
config :thx_core, gpio_proxy: ThxCore.FakeGpioProxy
