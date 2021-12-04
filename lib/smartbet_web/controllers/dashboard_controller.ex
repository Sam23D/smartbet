defmodule SmartbetWeb.DashboardController do
    use SmartbetWeb, :controller

    alias Smartbet.Bets.UserBets
    alias Smartbet.Sports

    # plug :put_layout, "dashboard_layout.html"

    def index(conn, _params) do
      changeset = UserBets.changeset(%UserBets{}, %{})
      render(conn, "index.html", changeset: changeset)
    end

    def scores(conn, _params) do
      changeset = UserBets.changeset(%UserBets{}, %{})
      leagues = Sports.list_tracked_basketball_leagues()
      render(conn, "scores.html", changeset: changeset, leagues: leagues)
    end


  end
