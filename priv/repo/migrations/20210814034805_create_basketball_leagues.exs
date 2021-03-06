defmodule Smartbet.Repo.Migrations.CreateBasketballLeagues do
  use Ecto.Migration

  def change do
    create table(:basketball_leagues) do
      add :logo_imgurl, :string
      add :source_id, :integer
      add :name, :string
      add :type, :string
      add :seasons, {:array, :map}
      add :api_source, :string, is_primary: true
      add :fetched_at, :utc_datetime

      # add belongs_to :country, CountrySchema
      # TODO add api_source (:sports_api) # TODO make Enum for APISources
      add :games_crawled_at, :utc_datetime
      add :being_tracked?, :boolean, default: false
      add :season_ends, :utc_datetime # this is used to disable being_tracked?

      # make composite key with name & type
      timestamps()
    end

    create index(:basketball_leagues, [:name, :type], unique: true)
    create index(:basketball_leagues, [:source_id], unique: true)
    create index(:basketball_leagues, [:being_tracked?])

  end
end
