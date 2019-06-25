ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ThxData.Repo, :manual)
# Ecto.Adapters.SQL.Sandbox.checkout(ThxCore.Repo)

# Code.eval_file "priv/repo/seeds.exs"

Mox.defmock(Test.GpioProxyMock, for: ThxCore.GpioProxyBehaviour)
