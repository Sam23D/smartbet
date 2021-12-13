
defmodule SmartbetWeb.BasketballLeagueLive do
  use SmartbetWeb, :live_view

  alias Smartbet.Sports.BasketballLeague
  alias Smartbet.Accounts
  alias Smartbet.Sports

  def mount(params, _session, socket) do
    current_user = Accounts.get_user_by_session_token(Accounts.get_current_user_token(socket))
    IO.inspect("#{}", label: "LEAGUE PARAMS")
    league_live_console_changeset = BasketballLeague.live_console_changeset(%BasketballLeague{}, %{})
    {:ok, assign(socket, changeset: league_live_console_changeset, current_user: current_user)}
  end

  def handle_params(params, _uri, socket) do
    # Get league name and fetch games for corresponding league
    case params do
      %{"league_id" => league_id} ->
        league = Sports.get_league!(%{ "league_id" => String.to_integer(league_id)})
        |> IO.inspect(label: "LEAGUE FROM PARAMS")
        {:noreply, assign(socket, league: league)}
      params ->
        IO.inspect(params, label: "Getting this params")
        {:noreply, socket}
    end
  end


end
