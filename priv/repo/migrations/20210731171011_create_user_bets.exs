defmodule Smartbet.Repo.Migrations.CreateUserBets do
  use Ecto.Migration

  def change do
    create table(:user_bets) do
      add :sport, :string
      add :platform, :string
      add :event_headline, :string
      add :details, :string
      add :amount, :decimal
      add :line, :decimal
      add :odds, :integer
      add :bet_result, :string
      add :profit, :decimal

      timestamps()
    end

  end
end
