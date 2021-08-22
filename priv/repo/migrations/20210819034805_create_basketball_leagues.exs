defmodule Smartbet.Repo.Migrations.CreateBasketballLeagues do
  use Ecto.Migration

  def change do
    create table(:basketball_leagues) do
      add :logo_imgurl, :string
      add :source_id, :integer
      add :name, :string
      add :type, :string
      add :seasons, {:array, :map}
      add :api_source, :string

      # add belongs_to :country, CountrySchema
      # TODO add api_source (:sports_api) # TODO make Enum for APISources

      # make composite key with name & type
      timestamps()
    end

    create index(:basketball_leagues, [:name, :type], unique: true)


  end
end
