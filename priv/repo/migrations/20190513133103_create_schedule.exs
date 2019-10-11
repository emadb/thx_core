defmodule ThxCore.Repo.Migrations.CreateSchedule do
  use Ecto.Migration

  def change do
    create table(:schedule) do
      add :sensor_id, references(:sensor)
      add :weekday, :string
      add :temperature, {:array, :integer}
    end

  end
end
