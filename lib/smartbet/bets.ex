defmodule Smartbet.Bets do
  @moduledoc """
  The Bets context.
  """

  import Ecto.Query, warn: false
  alias Smartbet.Repo

  alias Smartbet.Bets.UserBets

  @doc """
  Returns the list of user_bets.

  ## Examples

      iex> list_user_bets()
      [%UserBets{}, ...]

  """
  def list_user_bets do
    Repo.all(UserBets)
  end

  @doc """
  Gets a single user_bets.

  Raises `Ecto.NoResultsError` if the User bets does not exist.

  ## Examples

      iex> get_user_bets!(123)
      %UserBets{}

      iex> get_user_bets!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_bets!(id), do: Repo.get!(UserBets, id)

  @doc """
  Creates a user_bets.

  ## Examples

      iex> create_user_bets(%{field: value})
      {:ok, %UserBets{}}

      iex> create_user_bets(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_bets(attrs \\ %{}) do
    %UserBets{}
    |> UserBets.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_bets.

  ## Examples

      iex> update_user_bets(user_bets, %{field: new_value})
      {:ok, %UserBets{}}

      iex> update_user_bets(user_bets, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_bets(%UserBets{} = user_bets, attrs) do
    user_bets
    |> UserBets.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates the user bet and also recalculates profit
  """
  def update_user_bets_and_profit(%UserBets{} = user_bets, attrs)do
    user_bets
    |> UserBets.profit_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_bets.

  ## Examples

      iex> delete_user_bets(user_bets)
      {:ok, %UserBets{}}

      iex> delete_user_bets(user_bets)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_bets(%UserBets{} = user_bets) do
    Repo.delete(user_bets)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_bets changes.

  ## Examples

      iex> change_user_bets(user_bets)
      %Ecto.Changeset{data: %UserBets{}}

  """
  def change_user_bets(%UserBets{} = user_bets, attrs \\ %{}) do
    UserBets.changeset(user_bets, attrs)
  end

  def get_all_bets_from_user(bet_result) do
    query = from bet in UserBets,
      where: bet.bet_result == ^bet_result,
      select: bet
    Repo.all(query)
    |> Enum.count
  end

  def count_bet_count(user_bets_list) do
    wins = Enum.filter(user_bets_list, fn bet -> bet.bet_result == "Win" end)
    |> Enum.count
    loses = Enum.filter(user_bets_list, fn bet -> bet.bet_result == "Lost" end)
    |> Enum.count
    pendings = Enum.filter(user_bets_list, fn bet -> bet.bet_result == "Pending" end)
    |> Enum.count
    %{wins: wins, loses: loses, pendings: pendings}
  end

  def net_profit(user_bets_list) do
    Enum.map(user_bets_list, fn user_bet -> user_bet.profit end)
    |> Enum.reduce(Decimal.new(0),fn x, acc -> Decimal.add(x,acc) end)
  end
end
