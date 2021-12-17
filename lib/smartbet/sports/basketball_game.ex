defmodule Smartbet.Sports.BasketballGame do
  use Ecto.Schema
  import Ecto.Changeset

  alias Smartbet.Sports.BasketballGameRecord
  alias Smartbet.Sports.BasketballTeam
  alias Smartbet.Sports.BasketballLeague
  @moduledoc """
  This schema will store information about games for crawling, and autocomplete related information

  """

  schema "basketball_games" do
    field :game_data, :map
    field :game_datetime, :naive_datetime
    field :scores, :map # ??

    field :source_id, :integer
    field :source, :string
    field :game_headline, :string, required: true
    field :crawled_at, :naive_datetime
    field :plays_at, :utc_datetime # use to get incomming games

    field :game_played?, :boolean
    field :is_live?, :boolean

    has_many :game_records, BasketballGameRecord

    field :home, :integer
    field :visit, :integer
    field :league, :integer

    timestamps()
  end

  @doc false
  def changeset(outbound, attrs) do
    outbound
    |> cast(attrs, [:game_datetime, :source_id, :scores])
    |> validate_required([:game_datetime, :source_id, :scores])
  end

  def parse_params(game_params=%{"id" => source_id,  "timestamp" => timestamp, "scores" => scores, "teams" => %{ "away" => away, "home" => home }, "league" => league }, :sports_api)do
    {:ok, plays_at} = DateTime.from_unix(timestamp )
    game_headline = "[#{home["id"]}] #{home["name"]} VS [#{away["id"]}] #{away["name"]} - #{league["name"]}"
    %{ game_data: game_params, game_headline: game_headline, home: home["id"], visit: away["id"], league: league["id"], source_id: source_id, scores: scores, plays_at: plays_at, source: :sports_api}
  end

  def sports_api_changest(basketball_game, attrs)do
    basketball_game
    |> cast(attrs, [:home, :visit, :league, :game_headline, :source_id, :plays_at, :scores, :game_data])
    |> validate_required([:home, :visit, :league, :game_headline])
  end

end
