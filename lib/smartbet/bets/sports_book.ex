defmodule Smartbet.Bets.SportsBook do

  alias Smartbet.Bets.UserBets

  def get_bet_profit( user_bet ) do
    case user_bet do
      %{ bet_result: "Win" } ->

          if user_bet.odds > 0 do
            abs(user_bet.odds)
            |> Decimal.mult(user_bet.amount)
            |> Decimal.div( 100 )

          else
            Decimal.mult(user_bet.amount, 100)
            |> Decimal.div(abs(user_bet.odds))

          end

      %{ bet_result: "Lost" } ->
        Decimal.mult(user_bet.amount, Decimal.new(-1) )

      %{ bet_result: _ } ->
         0


    end
  end

end
