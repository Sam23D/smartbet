defmodule SmartbetWeb.AdminConsoleLive do
  use SmartbetWeb, :live_view

  alias Smartbet.Sports
  alias Smartbet.Sports.BasketballLeague

  def mount(_params, _session, socket) do
    leagues = Sports.list_tracked_basketball_leagues()
    league_live_console_changeset = BasketballLeague.live_console_changeset(%BasketballLeague{}, %{})
    {:ok, assign(socket,
        league_changeset: league_live_console_changeset, leagues: leagues )}
  end

  def handle_event("search_league", params, socket) do
    leagues = case params["league_name"] do
      "" -> Sports.list_tracked_basketball_leagues()
      league_name -> Sports.list_basketball_leagues_like(league_name)
    end
    {:noreply, assign(socket, leagues: leagues, search_league_name: params["league_name"] )}
  end

  def handle_event("toggle_league_tracking", params, socket) do
    # toggles league being_tracked if provided
    case params["basketball_league"] do
      %{"league_id" => str_id} ->
        {id, _} = Integer.parse(str_id)
        Sports.toggle_league_tracking(%{ id: id })
      nil -> nil
    end
    # returns leagues depending on search_input
    leagues = case socket.assigns[:search_league_name] do
      nil -> Sports.list_tracked_basketball_leagues()
      "" -> Sports.list_tracked_basketball_leagues()
      league_name -> Sports.list_basketball_leagues_like(league_name)
    end

    {:noreply, assign(socket, leagues: leagues)}
  end


end
