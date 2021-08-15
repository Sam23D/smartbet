defmodule Smartbet.Repo.Migrations.CreateBasketballTeams do
  use Ecto.Migration

  def change do
    create table(:basketball_teams) do
      add :logo_imgurl, :string
      add :source_id, :integer
      add :source, :string
      add :name, :string
      add :national, :boolean, default: false, null: false

      timestamps()
    end

  end
end
