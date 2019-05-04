defmodule ThxCore.Repo.Migrations.CreateTemperature do
  use Ecto.Migration

  def change do
    create table(:temperature) do
      add :sensor_id, references("sensor")
      add :date, :date
      add :value, :float
    end

  end
end
