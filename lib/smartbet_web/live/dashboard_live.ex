defmodule SmartbetWeb.DashboardLive do
  use SmartbetWeb, :live_view

  alias Smartbet.Bets
  alias Smartbet.Bets.UserBets
  alias Smartbet.Bets.SportsBook
  alias SmartbetWeb.Components.Huro

  import SmartbetWeb.UserBetsView, only: [pretty_print_date: 1, result_class: 1]

  def mount(params, session, socket) do
    user_bets = Bets.list_user_bets(params)
    # all_user_bets = conn.assigns.current_user.id
    current_user = Smartbet.Accounts.get_user_by_session_token(session["user_token"])
    all_user_bets = current_user
    |> IO.inspect(label: "current user")
    |> Bets.all_user_bets()

    changeset = Bets.change_user_bets(%UserBets{})
    bet_count = Bets.count_bet_count(all_user_bets)
    net_profit = Bets.net_profit(all_user_bets) # this will ventually calculate the users user_bets_summary
    new_socket = assign(socket,
    current_user: current_user,
    user_bets: user_bets,
    changeset: changeset,
    bet_count: bet_count,
    net_profit: net_profit)
    |> IO.inspect(label: "New Socket")
    {:ok, new_socket,
    layout: {SmartbetWeb.LayoutView, "user_live.html"}}
  end


  # def render(assigns)do
  #   ~H"""
  #   Live DASHBOARD
  #   """
  # end

end
