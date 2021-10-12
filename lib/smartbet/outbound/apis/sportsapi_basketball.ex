defmodule Smartbet.Outbound.APIs.SportsAPIBasketball do
  use Tesla

  # TODO extract to ENVAR

  # This plugs will add the configured parameters for each requesto, for the system

  plug Tesla.Middleware.BaseUrl, "https://v1.basketball.api-sports.io"
  plug Tesla.Middleware.Headers, [{"x-apisports-key", "33197267305bc5bfe95a2dac1f393356"}]
  plug Tesla.Middleware.JSON

  @doc """
  Gets the leagues from a given league name
  get_leagues( params \\ %{name: "NBA"})
  """
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

  @doc """
  Will fetch all the games from a given league by, a given season and source league id, this can be used
  for daily league crawling, as it will request all the league games
  get_games(%{league_id: league_src_id, season: iso_date }) # prefered for daily crawl
  get_games(%{league: 12, season: "2019-2020", date: "2019-11-23", timezone: "Europe/london" })

  """
  def get_games(params\\%{ date: "2021-10-11", league: 12, season: "2020-2021" })do
    with %{ league: _league_id }=req_params <- params,
    {:ok, resp } <- get( "/games", query: Map.to_list(req_params) )
    do

        IO.inspect(resp, label: "SportsAPI [ Basketball ] - Response")
        resp.body["response"]
    else
      error ->
        IO.inspect(error)
        {:error, "could not game for #{params}"}

    end
  end
  # TODO get_games() // by date, by league

  # TODO get_game()


end
