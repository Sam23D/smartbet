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
end
