defmodule ThxCore.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias ThxData.Repo

      import Ecto
      import Ecto.Query
      import ThxCore.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ThxData.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ThxData.Repo, {:shared, self()})
    end

    :ok
  end
end
