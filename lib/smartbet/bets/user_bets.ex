defmodule Smartbet.Bets.UserBets do
  use Ecto.Schema
  import Ecto.Changeset

  alias Smartbet.Accounts.User
  alias Smartbet.Bets.SportsBook

  schema "user_bets" do
    field :amount, :decimal
    field :details, :string

    field :bet_result, :string, default: "Pending"
    field :event_headline, :string

    field :line, :decimal
    field :platform, :string
    field :profit, :decimal, default: 0
    field :sport, :string
    field :odds, :integer
    field :type, :string, default: "Money Line"

    belongs_to :user, User

    # Add field :league, :reference to league
    timestamps()
  end

  @doc false
  def changeset(user_bets, attrs) do
    user_bets
    |> cast(attrs, [:sport, :platform, :event_headline, :details, :odds, :amount, :line, :bet_result, :profit, :type])
    |> validate_required([:sport, :platform, :event_headline, :details, :odds, :amount, :line])
  end

  def profit_changeset(user_bets, attrs) do
    user_bets
    |> cast(attrs, [:sport, :platform, :event_headline, :details, :odds, :amount, :line, :bet_result, :profit, :type])
    |> recalculate_profit()
    |> validate_required([:sport, :platform, :event_headline, :details, :odds, :amount, :line])
  end

  def recalculate_profit( changeset )do
    updated_bet = apply_changes(changeset)
    changeset.data
    |> case do
      %{ odds: _ } ->
        changeset
        |> put_change( :profit, SportsBook.get_bet_profit(updated_bet) )

      %{ ammunt: _ } -> changeset
        |> put_change( :profit, SportsBook.get_bet_profit(updated_bet) )

      %{ bet_result: _ } -> changeset
        |> put_change( :profit, SportsBook.get_bet_profit(updated_bet) )

      _ ->
        changeset
    end
  end

end
