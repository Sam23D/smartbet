defmodule Smartbet.Sports.Country do
  use Ecto.Schema
  import Ecto.Changeset

  schema "countries" do
    field :code, :string
    field :flag_imgurl, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:flag_imgurl, :id, :name, :code])
    |> validate_required([:flag_imgurl, :id, :name, :code])
  end
end
