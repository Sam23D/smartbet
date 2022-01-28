defmodule SmartbetWeb.UserBetsLive do
  use SmartbetWeb, :live_view

  @moduledoc """
  This module renders the live_view for the user bets, here we can:
  - place a bet
  - view all my bets
  - filter my bets by date ranges


  """

  import SmartbetWeb.UserBetsView, only: [pretty_print_date: 1, profit_color: 1, result_class: 1]

  alias Smartbet.Bets
  alias Smartbet.Sports
  alias Smartbet.Bets.UserBets
  alias Smartbet.Bets.SportsBook
  alias Smartbet.Accounts
  alias Smartbet.Accounts.User
  alias SmartbetWeb.Components.Huro

  def mount(params, session, socket)do
    IO.inspect("User bets live")

    # user_bets = Bets.list_user_bets(params)
    # all_user_bets = conn.assigns.current_user.id
    user = %User{} = session["user_token"]
    |> Accounts.get_user_by_session_token()
    user_bets = Bets.list_user_bets(user)
    all_user_bets = user.id
    |> Bets.all_user_bets()
    # get all tracked leagues
    tracked_leagues = Sports.get_tracked_leagues()
    |> IO.inspect(label: "tracked leagues")
    changeset = Bets.change_user_bets(%UserBets{})
    bet_count = Bets.count_bet_count(all_user_bets)
    net_profit = Bets.net_profit(all_user_bets) # this will ventually calculate the users user_bets_summary

    {:ok, assign(socket,
      user_bets: user_bets,
      changeset: changeset,
      bet_count: bet_count,
      net_profit: net_profit,
      tracked_leagues: tracked_leagues,
      league_teams: []
      )}
  end

  def handle_params(params, _uri, socket) do
    # TODO add select_home

    # TODO add select_visit

    # TODO add odds

    # TODO modify ammount
    {:noreply, socket}
  end


  # handle_event "update league"
  # handle_event "update_team_name"
  # handle_event "select_team"

  def handle_event("update_user_bet_params", params, socket) do
    params
    # game_params = home + visit


    new_socket = case params do
      %{"_target" => [_, "game_league"], "user_bets" => %{ "game_league" => league_id}} ->
        params
        |> IO.inspect(label: "params")
        # get league teams
        league_teams = Sports.basketball_teams_from_lague(league_id)
        |> IO.inspect(label: "league teams")
        assign(socket, league_teams: league_teams)
        # assign team options

      %{"_target" => [_, "home"]} ->
        params
        |> IO.inspect(label: "Home name updated")
        # update game options
        socket

      %{"_target" => [_, "visit"]} ->
        params
        |> IO.inspect(label: "Visit name updated")
        # update game options
        socket

      params ->
        params
        |> IO.inspect(label: "PARAMS")

        socket
    end

    {:noreply, new_socket}
  end

  def handle_event("submit_user_bet", params, socket) do
    params
    |> IO.inspect(label: "PARAMS")

    {:noreply, socket}
  end



end
