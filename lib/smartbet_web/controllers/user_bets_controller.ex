defmodule SmartbetWeb.UserBetsController do
  use SmartbetWeb, :controller

  alias Smartbet.Bets
  alias Smartbet.Bets.UserBets

  plug :put_layout, "dashboard_layout.html"


  def index(conn, _params) do
    user_bets = Bets.list_user_bets()
    changeset = Bets.change_user_bets(%UserBets{})
    render(conn, "index.html", user_bets: user_bets, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Bets.change_user_bets(%UserBets{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_bets" => user_bets_params}) do
    # TODO get conn.user_id and add it to user_bet
    case Bets.create_user_bets(user_bets_params) do
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


    bet_profit = case result do
      "Lost" ->
          Decimal.mult(user_bets.amount, Decimal.new(-1) )
          |> IO.inspect( label: "LOST RESULT" )

      "Win" ->
        if user_bets.odds > 0 do
          abs(user_bets.odds)
          |> Decimal.mult(user_bets.amount)
          |> Decimal.div( 100 )
          |> IO.inspect( label: "POSITIVE ODDS WIN RESULT" )
        else
          Decimal.mult(user_bets.amount, 100)
          |> Decimal.div(abs(user_bets.odds))
          |> IO.inspect( label: "NEGATIVE ODDS WIN RESULT" )

        end
    end

    case Bets.update_user_bets(user_bets, %{ bet_result: result, profit: bet_profit }) do
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

    case Bets.update_user_bets(user_bets, user_bets_params) do
      {:ok, user_bets} ->
        user_bets = Bets.list_user_bets()
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
