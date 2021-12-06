defmodule SmartbetWeb.AdminConsoleLive do
  use SmartbetWeb, :live_view

  alias Smartbet.Sports
  alias Smartbet.Sports.BasketballLeague
  alias Smartbet.Outbound.SportsAPIBasketballFetcher
  alias Smartbet.Accounts

  def mount(_params, _session, socket) do
    IO.inspect(socket.private)
    current_user = Accounts.get_user_by_session_token(get_current_user_token(socket))
    leagues = Sports.list_tracked_basketball_leagues()
    league_live_console_changeset = BasketballLeague.live_console_changeset(%BasketballLeague{}, %{})
    league_tracked_stats = Sports.get_league_tracking_data(leagues)
    {:ok, assign(socket, changeset: league_live_console_changeset, current_user: current_user,
        league_changeset: league_live_console_changeset, leagues: leagues, league_tracked_stats: league_tracked_stats )}
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
    all_leagues = Sports.list_tracked_basketball_leagues()
    league_tracked_stats = Sports.get_league_tracking_data(all_leagues)
    {:noreply, assign(socket, leagues: leagues, league_tracked_stats: league_tracked_stats)}
  end

  def handle_event("clear_flash", _params, socket) do
    {:noreply, clear_flash(socket)}
  end

  def handle_info("clear_flash", socket) do
    {:noreply, clear_flash(socket)}
  end

  def handle_event("fetch_league_games", %{"league_id" => league_id}=params, socket) do
    IO.inspect("Fetching games dat")
    # season
    #{:ok, games} = SportsAPIBasketballFetcher.fetch_games(:today, league_id)
    # total_fetched_games = Enum.count(games)
    total_fetched_games = 10
    IO.inspect("Fetched #{total_fetched_games} games")

    {:noreply, _put_dismissalbe_flash(socket, :success, "Fetched and updated #{total_fetched_games} games into the database")}

  end

  @supported_flash_types [:success, :error]
  def _put_dismissalbe_flash(socket, type, message, opts \\ [ms: 3_500]) when type in @supported_flash_types do
    # send after a "clear_flasj" message by default
    Process.send_after(self(), "clear_flash", min( opts[:ms], 15_000 ))
    IO.inspect("sending after #{ opts[:ms] }")
    put_flash(socket, type, message)
  end

  def _put_dismissalbe_flash(_, _, _, _), do: raise ArgumentError, message: "Only supported flash types are: #{@supported_flash_types}"

  def get_current_user_token(params)do
    case params.private do
      %{connect_info: %{session: session }} ->
        session["user_token"]
      %{conn_session: conn_sesion} ->
        conn_sesion["user_token"]
    end
  end

end
