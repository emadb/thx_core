defmodule ThxCore.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias ThxCore.Repo

      import Ecto
      import Ecto.Query
      import ThxCore.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ThxCore.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ThxCore.Repo, {:shared, self()})
    end

    :ok
  end
end
