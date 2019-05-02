defmodule ThxCore.Repo.Migrations.CreateSensorsTable do
  use Ecto.Migration

  def change do
    create table(:sensor) do
      add :name, :string
      add :description, :string
    end
  end
end
