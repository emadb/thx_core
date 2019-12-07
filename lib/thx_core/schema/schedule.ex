defmodule ThxCore.Schema.Schedule do
  use Ecto.Schema

  schema "schedule" do
    belongs_to :sensor, ThxCore.Schema.Sensor
    field :weekday, :string
    field :temperature, {:array, :integer}
  end
end
