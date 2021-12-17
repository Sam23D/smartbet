defmodule Smartbet.Repo.Migrations.AddsBasketballGameTracking do
  use Ecto.Migration

  def change do

    alter table(:basketball_games) do
      add :being_tracked?, :boolean, default: true
      add :current_season, :string
    end

    create index(:basketball_games, [:being_tracked?])
    create index(:basketball_games, [:current_season])
  end

end
