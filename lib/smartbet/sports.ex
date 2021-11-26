defmodule Smartbet.Sports do
  @moduledoc """
  The Sports context.
  """

  import Ecto.Query, warn: false
  alias Smartbet.Repo

  alias Smartbet.Sports.BasketballTeam

  @doc """
  Returns the list of basketball_teams.

  ## Examples

      iex> list_basketball_teams()
      [%BasketballTeam{}, ...]

  """
  def list_basketball_teams do
    Repo.all(BasketballTeam)
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
  Returns an `%Ecto.Changeset{}` for tracking country changes.

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{data: %Country{}}

  """
  def change_country(%Country{} = country, attrs \\ %{}) do
    Country.changeset(country, attrs)
  end
end
