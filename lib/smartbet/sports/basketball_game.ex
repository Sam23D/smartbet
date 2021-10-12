defmodule Smartbet.Sports.BasketballGame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "basketball_games" do
    field :game_datetime, :naive_datetime
    field :source_id, :integer
    field :scores, :map

    timestamps()
  end

  @doc false
  def changeset(outbound, attrs) do
    outbound
    |> cast(attrs, [:game_datetime, :source_id, :scores])
    |> validate_required([:game_datetime, :source_id, :scores])
  end
end
