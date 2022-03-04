defmodule Smartbet.Sports do
  @moduledoc """
  The Sports context.
  """

  import Ecto.Query, warn: false
  alias Smartbet.Repo

  alias Smartbet.Sports.BasketballTeam
  alias Smartbet.Sports.BasketballGame

  @doc """
  Returns the list of basketball_teams.

  ## Examples

      iex> list_basketball_teams()
      [%BasketballTeam{}, ...]

  """
  def list_basketball_teams do
    Repo.all(BasketballTeam)
  end

  def basketball_teams_from_lague( league_id ) when is_binary(league_id) do
    basketball_teams_from_lague( String.to_integer(league_id) )
  end

  def basketball_teams_from_lague( league_id ) do
    query = from team in BasketballTeam,
      where: team.league_id == ^league_id
    Repo.all(query)
  end

  @doc """
  Gets a single basketball_team.

  Raises `Ecto.NoResultsError` if the Basketball team does not exist.

  ## Examples

      iex> get_basketball_team!(123)
      %BasketballTeam{}

      iex> get_basketball_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_basketball_team!(id), do: Repo.get!(BasketballTeam, id)

  @doc """
  Creates a basketball_team.

  ## Examples

      iex> create_basketball_team(%{field: value})
      {:ok, %BasketballTeam{}}

      iex> create_basketball_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_basketball_team(attrs \\ %{}) do
    %BasketballTeam{}
    |> BasketballTeam.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a basketball_team.

  ## Examples

      iex> update_basketball_team(basketball_team, %{field: new_value})
      {:ok, %BasketballTeam{}}

      iex> update_basketball_team(basketball_team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_basketball_team(%BasketballTeam{} = basketball_team, attrs) do
    basketball_team
    |> BasketballTeam.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a basketball_team.

  ## Examples

      iex> delete_basketball_team(basketball_team)
      {:ok, %BasketballTeam{}}

      iex> delete_basketball_team(basketball_team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_basketball_team(%BasketballTeam{} = basketball_team) do
    Repo.delete(basketball_team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking basketball_team changes.

  ## Examples

      iex> change_basketball_team(basketball_team)
      %Ecto.Changeset{data: %BasketballTeam{}}

  """
  def change_basketball_team(%BasketballTeam{} = basketball_team, attrs \\ %{}) do
    BasketballTeam.changeset(basketball_team, attrs)
  end

  alias Smartbet.Sports.BasketballLeague

  @doc """
  Returns the list of basketball_leagues.

  ## Examples

      iex> list_basketball_leagues()
      [%BasketballLeague{}, ...]

  """
  def list_basketball_leagues do
    Repo.all(BasketballLeague)
  end

  @doc """
  Gets all leagues with being_tracked? == true
  """
  def list_tracked_basketball_leagues() do
    query = from league in BasketballLeague,
      where: league.being_tracked? == true
    Repo.all(query)
  end

  def list_basketball_leagues_like(league_name)do
    like_str = "%#{league_name}%"
    query = from league in BasketballLeague,
      where: ilike(league.name, ^like_str),
      order_by: league.name
    Repo.all(query)
  end
  @doc """
  Given a list of tracked leagues, will return a series of statistics about it
  """
  def get_league_tracking_data(tracked_leagues) do
    %{ total_tracked_leagues: Enum.count(tracked_leagues),
      current_season: get_season(Date.utc_today())
    }
  end

  @doc """
  Gets a single basketball_leage.

  Raises `Ecto.NoResultsError` if the Basketball leage does not exist.

  ## Examples

      iex> get_basketball_leage!(123)
      %BasketballLeague{}

      iex> get_basketball_leage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_basketball_leage!(id), do: Repo.get!(BasketballLeague, id)

  @doc """
  Creates a basketball_leage.

  ## Examples

      iex> create_basketball_leage(%{field: value})
      {:ok, %BasketballLeague{}}

      iex> create_basketball_leage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_basketball_leage(attrs \\ %{}) do
    %BasketballLeague{}
    |> BasketballLeague.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a basketball_leage.

  ## Examples

      iex> update_basketball_leage(basketball_leage, %{field: new_value})
      {:ok, %BasketballLeague{}}

      iex> update_basketball_leage(basketball_leage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_basketball_leage(%BasketballLeague{} = basketball_leage, attrs) do
    basketball_leage
    |> BasketballLeague.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a basketball_leage.

  ## Examples

      iex> delete_basketball_leage(basketball_leage)
      {:ok, %BasketballLeague{}}

      iex> delete_basketball_leage(basketball_leage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_basketball_leage(%BasketballLeague{} = basketball_leage) do
    Repo.delete(basketball_leage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking basketball_leage changes.

  ## Examples

      iex> change_basketball_leage(basketball_leage)
      %Ecto.Changeset{data: %BasketballLeague{}}

  """
  def change_basketball_leage(%BasketballLeague{} = basketball_leage, attrs \\ %{}) do
    BasketballLeague.changeset(basketball_leage, attrs)
  end

  @doc """
  # TODO
  # [ ] checks if that league exists, and if has been fetched today or at all
  # [ ] the request the API for the league information, then persists it into the DB as well as its games
  #
  """
  def fetch_league_information(%{id: id})do

  end

  @doc """
  Returns all games for a given league on a given date
  """
  def get_league_games(%{ league: league_id }, :today),
    do: get_league_games(%{league: league_id, date: DateTime.utc_now()})

  def get_league_games(%{ league: league_id, date: date })do
    tomorrow = DateTime.add(date, 1 * 24 *60*60, :second) # change 1 for other number is more days are required
    query = from game in BasketballGame,
      where: game.league == ^league_id,
      where: game.plays_at > ^date,
      where: game.plays_at < ^tomorrow

    Repo.all(query)
  end

  @doc """
  Usefull for searching games based on partial team names, this can be used in different ways such as:

  Will search all the games that the headline contains the query
  > search_game(%{ query: "red so" })

  Will search all the games where the given id is the home team by default or visit
  > search_game(%{ query: "", league: legue_id })
  > search_game(%{ home: id, league: legue_id, as: :visit })

  Will search all the games for the specified home & visit teams
  > search_game(%{league: id, home: home_id, visit: visit_id  })

  """
  @spec search_game(map()) :: list(map())
  def search_game(%{ query: query, league: id , as: playing_as })do
    ilike_str = "%#{query}%"
    case playing_as do
      "visit" ->
        query = from game in BasketballGame,
          where: game.league == ^id,
          where: fragment("?->'teams'->'away'->>'name' ilike ?", game.game_data, ^ilike_str),
          order_by: [asc: game.plays_at]
      "home" ->
        query = from game in BasketballGame,
          where: game.league == ^id,
          where: fragment("?->'teams'->'home'->>'name' ilike ?", game.game_data, ^ilike_str),
          order_by: [asc: game.plays_at]
    end
    |> Repo.all()
  end

  def search_game(%{ query: query, league: id  })do
    ilike_str = "%#{query}%"
    query = from game in BasketballGame,
      where: game.league == ^ id,
      where: ilike(game.game_headline, ^ilike_str),
      order_by: [asc: game.plays_at]
    Repo.all(query)
  end

  def search_game(%{ query: query  })do
    ilike_str = "%#{query}%"
    query = from game in BasketballGame,
      where: ilike(game.game_headline, ^ilike_str),
      order_by: [asc: game.plays_at]
    Repo.all(query)
  end

  def search_game(%{league: league_id, home: home_id, visit: visit_id  })do
    query = from game in BasketballGame,
      where: game.league == ^ league_id,
      where: game.home == ^home_id,
      where: game.visit == ^visit_id

    Repo.all(query)
  end
  @doc """
  Takes a league, and sets it's being_tracked? attribute to `true`, this will take the league into account for system's crawling/tracking
  ```
  Smartbet.Sports.toggle_league_tracking(%{id: 1}) # toggles on the current value
  Smartbet.Sports.toggle_league_tracking(%{id: 1}, set_val: true) # sets value to :set_val
  ```
  """
  def toggle_league_tracking(%{ id: id }, opts \\ [])do
    league = get_basketball_leage!(id)
    set_to_being_tracked = opts[:set_val] || !league.being_tracked?
    update_basketball_leage(league, %{being_tracked?: set_to_being_tracked })
  end

  @doc """
  Returns all leagues that are marked for tracking
  """
  def get_tracked_leagues() do
    query = from league in BasketballLeague,
      where: league.being_tracked? == true
    Repo.all(query)
  end

  @doc """
  Returns a league with the given id, it will try to query for :source_id by default
  """
  def get_league!(%{ "league_id" => league_id }, [{:games, :preload}])do
    query = from league in BasketballLeague,
      where: league.source_id == ^league_id,
      preload: :games
    Repo.one!(query)
  end

  def get_league!(%{ "league_id" => league_id })do
    query = from league in BasketballLeague,
      where: league.source_id == ^league_id
    Repo.one!(query)
  end

  alias Smartbet.Sports.Country

  @doc """
  Returns the list of countries.

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  def list_countries do
    Repo.all(Country)
  end

  @doc """
  Gets a single country.

  Raises `Ecto.NoResultsError` if the Country does not exist.

  ## Examples

      iex> get_country!(123)
      %Country{}

      iex> get_country!(456)
      ** (Ecto.NoResultsError)

  """
  def get_country!(id), do: Repo.get!(Country, id)

  @doc """
  Creates a country.

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country(attrs \\ %{}) do
    %Country{}
    |> Country.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a country.

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country(%Country{} = country, attrs) do
    country
    |> Country.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a country.

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country(%Country{} = country) do
    Repo.delete(country)
  end

   @doc """
  Given a date 2010-01-01, will determine the corresponding season, being either
  2009-2010 & 2010-2011, depending on the month is greater or iqual than 7, it will return season for current and next year,
  otherwise if its <= month 6 it will return season for previous and current year
  """
  @spec get_season(Date.t()) :: String
  def get_season(date=%Date{month: m, year: year})do
    cond do
      m <= 6 ->
        "#{year - 1}-#{year}"
      m >= 7 ->
        "#{year}-#{year + 1}"
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country changes.

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{data: %Country{}}

  """
  def change_country(%Country{} = country, attrs \\ %{}) do
    Country.changeset(country, attrs)
  end

  @doc """
  Returns a list of names and id's to be used for autocomplete
  """
  def get_autocomplete_team_names(league, sport \\ :basketball )

  def get_autocomplete_team_names(%{id: league_id}=_league, :basketball ) do
    query = from team in BasketballTeam,
      where: team.league_id == ^league_id,
      select: {team.id, team.name, team.logo_imgurl}
    Repo.all(query)

  end


end
