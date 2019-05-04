defmodule ThxCore.Schema.Temperature do
  use Ecto.Schema

  schema "temperature" do
    belongs_to :sensor, ThxCore.Schema.Sensor
    field :date, :date
    field :value, :float
  end
end
