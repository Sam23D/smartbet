defmodule Smartbet.Sports.BasketballGameRecord do
  use Ecto.Schema
  import Ecto.Changeset

  alias Smartbet.Sports.BasketballTeam
  alias Smartbet.Sports.BasketballGame
  alias Smartbet.Sports.BasketballLeague

  @moduledoc """
  This module will keep a record of each game crawl session, where it will cache the information
  received from the api
  """

  schema "basketball_game_records" do
    field :game_data, :map
    field :game_headline, :string

    belongs_to :basketball_game, BasketballGame
    timestamps()
  end

  @doc false
  def changeset(game_record, attrs) do
    game_record
    |> cast(attrs, [ ])
    |> validate_required([ ])
  end
end
