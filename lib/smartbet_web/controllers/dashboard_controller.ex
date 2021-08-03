defmodule SmartbetWeb.DashboardController do
    use SmartbetWeb, :controller

    plug :put_layout, "dashboard_layout.html"

    def index(conn, _params) do
      render(conn, "index.html")
    end

    def scores(conn, _params) do
      render(conn, "scores.html")
    end


  end
