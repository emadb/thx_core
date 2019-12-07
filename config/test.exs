use Mix.Config
config :thx_core, ThxCore.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "thermox_test",
  username: "ema",
  password: "",
  pool: Ecto.Adapters.SQL.Sandbox

config :thx_core, sensor_reader: ThxCore.IO.FakeSensorReader
config :thx_core, gpio_proxy: ThxCore.FakeGpioProxy
