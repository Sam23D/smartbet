defmodule SmartbetWeb.UserBetsLive do
  use SmartbetWeb, :live_view

  import SmartbetWeb.UserBetsView, only: [pretty_print_date: 1, profit_color: 1, result_class: 1]

  alias Smartbet.Bets
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

    changeset = Bets.change_user_bets(%UserBets{})
    bet_count = Bets.count_bet_count(all_user_bets)
    net_profit = Bets.net_profit(all_user_bets) # this will ventually calculate the users user_bets_summary

    {:ok, assign(socket,
      user_bets: user_bets,
      changeset: changeset,
      bet_count: bet_count,
      net_profit: net_profit
      )}
  end



end
