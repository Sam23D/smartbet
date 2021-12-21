
defmodule SmartbetWeb.BasketballLeagueLive do
  use SmartbetWeb, :live_view

  alias Smartbet.Sports.BasketballLeague
  alias Smartbet.Accounts
  alias Smartbet.Sports
  alias Smartbet.GenericChangesets

  @valid_as ["home", "visit"]

  def mount(params, _session, socket) do
    current_user = Accounts.get_user_by_session_token(Accounts.get_current_user_token(socket))
    generic_search_params_filters_changeset =  GenericChangesets.generic_search_params_filters_changeset(params)

    {:ok, assign(socket, search_changeset: generic_search_params_filters_changeset, current_user: current_user)}
  end

  def handle_params(params, _uri, socket) do
    # TODO make a type of check in order to not fetch the league each time if it is already in the socket
    case params do
      %{"league_id" => str_league_id, "query" => query, "as" => as } when as in @valid_as ->
        league_id = String.to_integer(str_league_id)
        league = Sports.get_league!(%{ "league_id" => league_id, "query" => query})
        games = Sports.search_game(%{ query: query, league: league_id, as: as })
        {:noreply, assign(socket, league: league, games: games, query: query )}
      %{"league_id" => str_league_id, "query" => query}->
        league_id = String.to_integer(str_league_id)
        league = Sports.get_league!(%{ "league_id" => league_id, "query" => query})
        games = Sports.search_game(%{ query: query, league: league_id })
        {:noreply, assign(socket, league: league, games: games, query: query )}
      %{"league_id" => league_id}->
        league = Sports.get_league!(%{ "league_id" => String.to_integer(league_id)}, games: :preload)
        {:noreply, assign(socket, league: league, games: league.games, query: "" )}
      params ->
        {:noreply, socket}
    end
  end

  # TODO refactor to get parameters only update url from phx-submit
  # TODO display games on update

  def handle_event("apply_league_filters_admin", params=%{ "gen_search_params" => search_params }, socket) do
    queried_games = case search_params do
      %{ "query" => query, "as" => as } when as in @valid_as ->
         Sports.search_game(%{ query: query, league: socket.assigns.league.source_id, as: as })
      %{ "query" => query} ->
        Sports.search_game(%{ query: query, league: socket.assigns.league.source_id })
    end
    changeset =  GenericChangesets.generic_search_params_filters_changeset(search_params)
    # TODO add live_patch to update params
    new_socket = assign(socket, games: queried_games, search_changeset: changeset)
    to = SmartbetWeb.Router.Helpers.live_path(socket, SmartbetWeb.BasketballLeagueLive, league_id: socket.assigns.league.source_id, query: search_params["query"])
    |> IO.inspect(label: "TO")
    {:noreply, push_patch(new_socket, to: to)}
  end


end
