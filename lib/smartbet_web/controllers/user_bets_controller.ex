defmodule SmartbetWeb.UserBetsController do
  use SmartbetWeb, :controller

  alias Smartbet.Bets
  alias Smartbet.Bets.UserBets
  alias Smartbet.Bets.SportsBook

  plug :put_layout, "dashboard_layout.html"


  def index(conn, params) do
    user_bets = Bets.list_user_bets(params)
    all_user_bets = conn.assigns.current_user.id
    |> IO.inspect(label: "current user")
    |> Bets.all_user_bets()
    changeset = Bets.change_user_bets(%UserBets{})
    bet_count = Bets.count_bet_count(all_user_bets)
    net_profit = Bets.net_profit(all_user_bets) # this will ventually calculate the users user_bets_summary
    render(conn, "index.html", user_bets: user_bets, changeset: changeset, bet_count: bet_count, net_profit: net_profit )
  end

  def new(conn, _params) do
    changeset = Bets.change_user_bets(%UserBets{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_bets" => user_bets_params}) do
    case Bets.create_user_bets(conn.assigns.current_user, user_bets_params) do
      {:ok, _user_bets} ->
        conn
        |> put_flash(:info, "User bets created successfully.")
        |> redirect(to: Routes.user_bets_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_bets = Bets.get_user_bets!(id)
    changeset = Bets.change_user_bets(user_bets)
    render(conn, "show.html", user_bets: user_bets, changeset: changeset)
  end

  def close_bet(conn, %{"id" => id, "bet_result" => result}) do
    user_bets = Bets.get_user_bets!(id)
    case Bets.update_user_bets_and_profit(user_bets, %{ bet_result: result }) do
      {:ok, _} ->
        conn
        |> redirect(to: Routes.user_bets_path(conn, :index))
    end

  end

  def edit(conn, %{"id" => id}) do
    user_bets = Bets.get_user_bets!(id)
    changeset = Bets.change_user_bets(user_bets)
    render(conn, "edit.html", user_bets: user_bets, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_bets" => user_bets_params}) do
    user_bets = Bets.get_user_bets!(id)
    case Bets.update_user_bets_and_profit(user_bets, user_bets_params) do
      {:ok, user_bets} ->
        user_bets = Bets.list_user_bets(%{})
        conn
        |> put_flash(:info, "User bets updated successfully.")
        |> redirect(to: Routes.user_bets_path(conn, :index, user_bets))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_bets: user_bets, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_bets = Bets.get_user_bets!(id)
    {:ok, _user_bets} = Bets.delete_user_bets(user_bets)

    conn
    |> put_flash(:info, "User bets deleted successfully.")
    |> redirect(to: Routes.user_bets_path(conn, :index))
  end
end
