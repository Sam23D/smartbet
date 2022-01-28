defmodule Smartbet.Sports.BasketballTeam do
  use Ecto.Schema
  import Ecto.Changeset

  Smartbet.Sports.BasketballLeague

  schema "basketball_teams" do
    field :logo_imgurl, :string
    field :name, :string
    field :national, :boolean, default: false
    field :source_id, :integer
    field :source, :string

    belongs_to :league,  BasketballLeague

    timestamps()
  end

  @doc false
  def changeset(basketball_team, attrs) do
    basketball_team
    |> cast(attrs, [:logo_imgurl, :source_id, :name, :national, :source])
    |> validate_required([:logo_imgurl, :source_id, :name, :national, :source])
  end
end
