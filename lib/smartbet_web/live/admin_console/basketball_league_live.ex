
defmodule SmartbetWeb.BasketballLeagueLive do
  use SmartbetWeb, :live_view

  alias Smartbet.Sports.BasketballLeague
  alias Smartbet.Accounts
  alias Smartbet.Sports
  alias Smartbet.GenericChangesets

  def mount(params, _session, socket) do
    current_user = Accounts.get_user_by_session_token(Accounts.get_current_user_token(socket))
    generic_search_params_filters_changeset =  GenericChangesets.generic_search_params_filters_changeset(params)

    {:ok, assign(socket, search_changeset: generic_search_params_filters_changeset, current_user: current_user)}
  end

  def handle_params(params, _uri, socket) do
    # Get league name and fetch games for corresponding league
    case params do
      %{"league_id" => league_id}->
        league = Sports.get_league!(%{ "league_id" => String.to_integer(league_id)}, games: :preload)
        {:noreply, assign(socket, league: league, games: league.games )}
      params ->
        {:noreply, socket}
    end
  end

  def handle_event("apply_league_filters_admin", params=%{ "gen_search_params" => search_params }, socket) do
    queried_games = case search_params do
      %{ "query" => query, "as" => "visit"} ->
         Sports.search_game(%{ query: query, league: socket.assigns.league.source_id, as: "visit" })
      %{ "query" => query, "as" => "home"} ->
        Sports.search_game(%{ query: query, league: socket.assigns.league.source_id, as: "home" })
      %{ "query" => query} ->
        Sports.search_game(%{ query: query, league: socket.assigns.league.source_id })
    end
    changeset =  GenericChangesets.generic_search_params_filters_changeset(search_params)
    {:noreply, assign(socket, games: queried_games, search_changeset: changeset)}
  end


end
