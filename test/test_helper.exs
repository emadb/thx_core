ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ThxCore.Repo, :manual)
Ecto.Adapters.SQL.Sandbox.checkout(ThxCore.Repo)

Code.eval_file "priv/repo/seeds.exs"

Mox.defmock(Test.ThermostatWriterMock, for: ThxCore.IO.ThermostatWriterBehaviour)
