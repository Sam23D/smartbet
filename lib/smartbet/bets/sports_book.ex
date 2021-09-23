defmodule Smartbet.Bets.SportsBook do

  alias Smartbet.Bets.UserBets

  def get_bet_profit( user_bet ) do
    case user_bet do
      %{ bet_result: "Win" } ->

          if user_bet.odds > 0 do
            abs(user_bet.odds)
            |> Decimal.mult(user_bet.amount)
            |> Decimal.div( 100 )
            |> IO.inspect( label: "POSITIVE ODDS WIN RESULT" )
          else
            Decimal.mult(user_bet.amount, 100)
            |> Decimal.div(abs(user_bet.odds))
            |> IO.inspect( label: "NEGATIVE ODDS WIN RESULT" )
          end

      %{ bet_result: "Lost" } ->
        Decimal.mult(user_bet.amount, Decimal.new(-1) )
        |> IO.inspect( label: "LOST RESULT" )

    end
  end

end
