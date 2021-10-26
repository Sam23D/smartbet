defmodule Smartbet.Sports.BasketballGame do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  This schema will store information about games for crawling, and autocomplete related information



  """

  schema "basketball_games" do
    field :game_datetime, :naive_datetime
    field :source_id, :integer
    field :scores, :map

    # TODO add :headline, :string

    # TODO add :crawled_at, :datetime
    # TODO add :played_at, :datetime



    timestamps()
  end

  @doc false
  def changeset(outbound, attrs) do
    outbound
    |> cast(attrs, [:game_datetime, :source_id, :scores])
    |> validate_required([:game_datetime, :source_id, :scores])
  end
end
