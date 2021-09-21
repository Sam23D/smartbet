defmodule Smartbet.Repo.Migrations.RefersUserToUserBet do
  use Ecto.Migration

  def change do
    alter table(:user_bets)do
      add :user_id, references(:users)
    end
  end

end
