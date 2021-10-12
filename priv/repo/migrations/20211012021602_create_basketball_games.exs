defmodule Smartbet.Repo.Migrations.CreateBasketballGames do
  use Ecto.Migration

  def change do
    create table(:basketball_games) do
      add :game_datetime, :naive_datetime
      add :source_id, :integer
      add :scores, :map

      timestamps()
    end
  end
end
