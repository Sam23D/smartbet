defmodule Smartbet.Repo.Migrations.CreateBasketballLeagues do
  use Ecto.Migration

  def change do
    create table(:basketball_leagues) do
      add :logo_imgurl, :string
      add :source_id, :integer
      add :name, :string
      add :type, :string
      add :seasons, :map

      timestamps()
    end

  end
end
