defmodule ThxCore.Repo.Migrations.CreateTemperature do
  use Ecto.Migration

  def change do
    create table(:temperature) do
      add :sensor_id, references("sensor")
      add :date, :utc_datetime_usec
      add :value, :float
    end

  end
end
