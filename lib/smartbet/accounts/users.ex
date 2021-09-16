defmodule Smartbet.Accounts.Users do
  alias Smartbet.Accounts.User

  alias Smartbet.Repo

  def user(id)do
    Repo.get(User, id)

  end

  def user_and_bets(id)do
    Repo.get(User, id)
    |> Repo.preload(:user_bets)
  end

end
