defmodule SmartbetWeb.DashboardController do
    use SmartbetWeb, :controller

    alias Smartbet.Bets.UserBets

    plug :put_layout, "dashboard_layout.html"

    def index(conn, _params) do
      changeset = UserBets.changeset(%UserBets{}, %{})
      render(conn, "index.html", changeset: changeset)
    end

    def scores(conn, _params) do
      changeset = UserBets.changeset(%UserBets{}, %{})
      render(conn, "scores.html", changeset: changeset)
    end


  end
