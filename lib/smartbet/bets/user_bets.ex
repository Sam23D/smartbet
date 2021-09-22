defmodule Smartbet.Bets.UserBets do
  use Ecto.Schema
  import Ecto.Changeset

  alias Smartbet.Accounts.User

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
end
