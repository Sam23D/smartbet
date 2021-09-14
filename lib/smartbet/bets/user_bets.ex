defmodule Smartbet.Bets.UserBets do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_bets" do
    field :amount, :decimal
    field :details, :string

    field :bet_result, :string, default: "Pending"
    field :event_headline, :string

    field :line, :decimal
    field :platform, :string
    field :profit, :decimal
    field :sport, :string
    field :odds, :integer
    # TODO add type of bet (spread, etc...)
    # TODO
    # Add field :league, :reference to league

    timestamps()
  end

  @doc false
  def changeset(user_bets, attrs) do
    user_bets
    |> cast(attrs, [:sport, :platform, :event_headline, :details, :odds, :amount, :line, :bet_result, :profit])
    |> validate_required([:sport, :platform, :event_headline, :details, :odds, :amount, :line])
  end
end
