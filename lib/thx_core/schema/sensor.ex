defmodule ThxCore.Schema.Sensor do
  use Ecto.Schema

  schema "sensor" do
    field :name, :string
    field :description, :string
  end
end
