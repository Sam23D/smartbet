defmodule Smartbet.Repo.Migrations.AddUserBetType do
  use Ecto.Migration

  def change do
    alter table(:user_bets) do
      add :type, :string

    end
  end

end
