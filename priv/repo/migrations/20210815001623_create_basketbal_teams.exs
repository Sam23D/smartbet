defmodule Smartbet.Repo.Migrations.CreateBasketballTeams do
  use Ecto.Migration

  def change do
    create table(:basketball_teams) do
      add :logo_imgurl, :string
      add :source_id, :integer, is_primary: true
      add :source, :string
      add :name, :string
      add :national, :boolean, default: false, null: false

      add :league_id, references(:basketball_leagues)

      timestamps()
    end

    # TODO add unique index to not repeat same teams across diferent leagues
    create index(:basketball_teams, [:source_id])
  end
end
