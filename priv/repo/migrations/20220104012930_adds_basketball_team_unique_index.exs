defmodule Smartbet.Repo.Migrations.AddsBasketballTeamUniqueIndex do
  use Ecto.Migration

  def change do
    create index(:basketball_teams, [:name, :source_id], unique: true)
  end

end
