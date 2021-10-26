defmodule Smartbet.Sports.BasketballGame do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  This schema will store information about games for crawling, and autocomplete related information



  """

  schema "basketball_games" do
    field :game_datetime, :naive_datetime
    field :scores, :map # ??

    field :source_id, :integer
    # TODO add field :source, :string // "sports_api"
    # TODO add :headline, :string

    # TODO add :crawled_at, :datetime
    # TODO add :plays_at, :datetime # use to get incomming games
    # TODO add :league, :string

    timestamps()
  end

  @doc false
  def changeset(outbound, attrs) do
    outbound
    |> cast(attrs, [:game_datetime, :source_id, :scores])
    |> validate_required([:game_datetime, :source_id, :scores])
  end
end
