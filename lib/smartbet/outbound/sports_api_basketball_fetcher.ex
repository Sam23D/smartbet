defmodule Smartbet.Outbound.SportsAPIBasketballFetcher do

  require Logger

  alias Smartbet.Outbound.APIs.SportsAPIBasketball
  alias Smartbet.Sports.{BasketballLeague, Country, BasketballTeam}
  alias Smartbet.Repo

  @moduledoc """
  This module will query the SportsAPI api and then insert all the entries in the DB to later use them as cached entitites.

  to populate the whole DB execute:
  iex> SportsAPIBasketballFetcher.fetch_all_countries :fetch_api
  iex> SportsAPIBasketballFetcher.fetch_all_leagues %{}, :fetch_api
  iex> SportsAPIBasketballFetcher.fetch_teams 12, :fetch_api
  """

  @doc """
  Fetches basketball leagues from SportAPI's enpoint and stores them in the Repository as a BasketballLeague
  should hold cached information on the db and have a :db_cache param,
  should return a list of basketball_leagues
  should have a :fetch_api param support to force a request to SportsAPI
  """
  def fetch_all_leagues( search_params \\ %{}, from \\ :db_cache )do
    # TODO
    case from do
      :db_cache ->
        Repo.all(BasketballLeague)

      :fetch_api ->
        now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
        placeholders = %{api_source: "SportsAPI", inserted_at: now, updated_at: now }
        league_entries = SportsAPIBasketball.get_leagues(search_params)
        parsed_entries = parse_leagues_result(league_entries)

        case Repo.insert_all(BasketballLeague, parsed_entries, placeholders: placeholders, on_conflict: :nothing) do
          {inserted, _updated}=result ->
            Logger.info("#{Enum.count(league_entries)} where fetched, #{inserted} basketball leagues were inserted from SportsAPI")
            Repo.all(BasketballLeague) # filter only the ones that where just inserted
        end
    end
    # option to skip DB storage should be added
  end

  @doc """
  Expects that the foreign schema from the SportsAPI matches with:
  ```
  %{"country" => %{"id" => 13, ... },
    "id" => 129,
    "logo" => "https://media.api-sports.io/basketball/leagues/129.png",
    "name" => "Denmark Cup",
    "seasons" => [%{"end" => "2021-04-03", "season" => "2020-2021", ...}, ... ],
    "type" => "cup"
  }
  ```
  """
  def parse_leagues_result(list_of_params)do
    list_of_params
    |> Enum.map(fn
      %{"country" => %{ "id" => _country_id }, # if resutl has no country this match will never happen
        "id" => source_id,
        "logo" => league_logo,
        "name" => league_name,
        "seasons" => league_seasons,
        "type" => league_type
      } ->
        [ name: league_name, logo_imgurl: league_logo, type: league_type, seasons: league_seasons, source_id: source_id,
          api_source:  {:placeholder, :api_source}, inserted_at:  {:placeholder, :inserted_at}, updated_at:  {:placeholder, :updated_at},
        ]

      _ ->
        raise ArgumentError, "SportsAPI result for basketball leagues has changed"

      end
      # turn all params into maps redy to be used by Ecto.insert_all
    )
  end

  @doc """
  Returns a list of al available countries in SportsAPI and persist them to the Repostory
  """
  def fetch_all_countries(from \\ :db_cache)do

    case from do

      :db_cache ->
        Repo.all(Country)

      :fetch_api ->
        now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
        placeholders = %{ inserted_at: now, updated_at: now }
        countries = SportsAPIBasketball.get_countries(%{})
        parsed_entries = parse_country_results(countries)

        case Repo.insert_all(Country, parsed_entries, placeholders: placeholders, on_conflict: :nothing) do
          {inserted, _updated} ->
            Logger.info("#{Enum.count(countries)} where fetched, #{inserted} countries were inserted from SportsAPI")
            Repo.all(Country)
        end

    end
  end

  def parse_country_results(list_of_countries)do
    list_of_countries
    |> Enum.map(fn
      %{"code" => code,
        "flag" => flag,
        "name" => name,
      } ->
        [ code: code, flag_imgurl: flag, name: name,
          inserted_at: {:placeholder, :inserted_at}, updated_at: {:placeholder, :updated_at} ]

      _ ->
        raise ArgumentError, "SportsAPI result for basketball leagues has changed"
      end)
  end


  @doc """
  Will fetch all teams from SportsAPI,given a league_id and a season ("2020-2021") is required
  iex> Smartbet.Outbound.APIs.SportsAPIBasketball.get_teams(%{ league: 12, season: "2020-2021" })
  """
  def fetch_teams_from_league( league_id \\ 12, season \\ "2020-2021" )do # NBA league
    with %BasketballLeague{ name: name } <- Repo.get_by( BasketballLeague, source_id: league_id ),
    _ <- IO.inspect("Fetching teams from league #{name}"),
      teams <- SportsAPIBasketball.get_teams(%{ league: league_id, season: "2020-2021" }),
      now <- NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      placeholders <- %{ inserted_at: now, updated_at: now }
    do
      parsed_entries = teams
      # prepares the data for Repo.insert_all
      |> Enum.map(fn
        %{"id" => source_id,
          "name" => name,
          "logo" => logo,
          "national" => national,
          } -> [source_id: source_id, name: name, logo_imgurl: logo, national: national,
                inserted_at:  {:placeholder, :inserted_at}, updated_at:  {:placeholder, :updated_at}]
        end)
      {number, _} = Repo.insert_all(BasketballTeam, parsed_entries, placeholders: placeholders, on_conflict: :nothing)
      IO.inspect("#{number} Basketball teams were inserted from SportsAPI")
    else
      _ -> {:error, "No league found with id: #{league_id}"}
    end
  end

  @doc """
  Fetches all games from a given team id on a given date
  fetch_games(%{ }=params\\%{ date: "2021-10-11", league: 12 })

  Fetches all games from a given date, such as all games from today # all games for league's season
  fetch_games(%{league_id: league_src_id, season: iso_date })
  fetch_games(%{league: 12, season: "2021-2022", date: "2021-10-11", timezone: "america/chihuahua" }) # specific date games

  [...,
  %{
     "country" => %{
       "code" => "US",
       "flag" => "https://media.api-sports.io/flags/us.svg",
       "id" => 5,
       "name" => "USA"
     },
     "date" => "2021-10-11T18:00:00-06:00",
     "id" => 137205,
     "league" => %{
       "id" => 12,
       "logo" => "https://media.api-sports.io/basketball/leagues/12.png",
       "name" => "NBA",
       "season" => "2021-2022",
       "type" => "League"
     },
     "scores" => %{
       "away" => %{
         "over_time" => nil,
         "quarter_1" => 27,
         "quarter_2" => 19,
         "quarter_3" => 21,
         "quarter_4" => nil,
         "total" => 67
       },
       "home" => %{
         "over_time" => nil,
         "quarter_1" => 34,
         "quarter_2" => 36,
         "quarter_3" => 21,
         "quarter_4" => nil,
         "total" => 91
       }
     }, ...]
  """
  # TODO def case for fetch_games(:today)
  #   must get current date, current timezone, and a league_id or game id
      # get_games(:today, league: 1), get_games(team: 1200, :today)

  def get_today_params() do
    today = Date.utc_today()
    %{date: today,
      season: get_season(today)
    }
  end

  @doc """
  Given a date 2010-01-01, will determine the corresponding season, being either
  2009-2010 & 2010-2011, depending on the month is greater or iqual than 7, it will return season for current and next year,
  otherwise if its <= month 6 it will return season for previous and current year
  """
  def get_season(date=%Date{month: m, year: year})do
    cond do
      m <= 6 ->
        "#{year - 1}-#{year}"
      m >= 7 ->
        "#{year}-#{year + 1}"
    end
  end


  def fetch_games( :today, league_id )do
        with true <- is_integer(league_id),
        %{season: season, date: today}=today_params <- get_today_params(),
        req_params <- today_params
          |> Map.put(:league, league_id)
          |> Map.put(:timezone, "america/chihuahua")

        do
          fetch_games(req_params)
        end
  end

  def fetch_games(params \\ %{league: 12, season: "2021-2022", timezone: "america/chihuahua" })do
    with league = %BasketballLeague{ name: name } <- Repo.get_by( BasketballLeague, source_id: params.league ),
    _ <- IO.inspect("Fetching teams from league #{name}"),
      # TBD implement cashing mechanism
      games <- SportsAPIBasketball.get_games(params)
      # TODO update league with fetched params in a task
      # create new game record per each game
      # TODO prepare data / adapter for information
      # TODO insert games into database
    do

      {:ok, games}
    else
      _ -> {:error, "Could not fetch basketball league"}

    end

  end



end
