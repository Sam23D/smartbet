defmodule Smartbet.Outbound.APIs.SportsAPIBasketball do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://v1.basketball.api-sports.io"
  plug Tesla.Middleware.Headers, [{"x-apisports-key", "33197267305bc5bfe95a2dac1f393356"}]
  plug Tesla.Middleware.JSON

  def get_leagues( params \\ %{name: "NBA"}) do
    case get("/leagues", query: Map.to_list(params)) do
      {:ok, resp } ->
        resp.body["response"]
        # parse all responses into a
      error ->
        IO.inspect(error)
        {:error, "could not fetch leagues"}
    end
  end

  def get_teams(params)do
    case get("/teams", query: Map.to_list(params)) do
      {:ok, resp } -> resp.body["response"]
      error ->
        IO.inspect(error)
        {:error, "could not fetch leagues"}
    end
  end

  def get_countries(params)do
    case get("/countries", query: Map.to_list(params)) do
      {:ok, resp } -> resp.body["response"]
      error ->
        IO.inspect(error)
        {:error, "could not fetch leagues"}
    end
  end

  # TODO get_games() // by date, by league

  # TODO get_game()


end
