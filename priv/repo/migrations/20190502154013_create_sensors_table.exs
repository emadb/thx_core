defmodule ThxCore.Repo.Migrations.CreateSensorsTable do
  use Ecto.Migration

  def change do
    create table(:sensor) do
      add :name, :string
      add :description, :string
      add :gpio, :integer
    end
  end
end
