defmodule Smartbet.Bets.UserBets do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_bets" do
    field :amount, :decimal
    field :bet_result, :string
    field :details, :string
    field :event_headline, :string
    field :line, :decimal
    field :platform, :string
    field :profit, :decimal
    field :sport, :string

    timestamps()
  end

  @doc false
  def changeset(user_bets, attrs) do
    user_bets
    |> cast(attrs, [:sport, :platform, :event_headline, :details, :amount, :line, :bet_result, :profit])
    |> validate_required([:sport, :platform, :event_headline, :details, :amount, :line, :bet_result, :profit])
  end
end
