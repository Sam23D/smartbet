defmodule Smartbet.Sports.BasketballLeage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "basketball_leagues" do
    field :logo_imgurl, :string
    field :name, :string
    field :seasons, :map
    field :source_id, :integer
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(basketball_leage, attrs) do
    basketball_leage
    |> cast(attrs, [:logo_imgurl, :source_id, :name, :type, :seasons])
    |> validate_required([:logo_imgurl, :source_id, :name, :type, :seasons])
  end
end
