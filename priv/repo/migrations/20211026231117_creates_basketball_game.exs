defmodule Smartbet.Repo.Migrations.CreatesBasketballGame do
  use Ecto.Migration

  def change do
    create table(:basketball_games)do
      add :game_data, :map
      add :game_headline, :string

      add :source, :string # "sports_api"

      add :game_datetime, :naive_datetime

      add :crawled_at, :naive_datetime
      add :plays_at, :utc_datetime # use to get incomming games
      add :game_played?, :boolean
      add :is_live?, :boolean

      # used for synching game information
      add :source_id, :integer

      add :scores, :map
      # composite index used for game creation and update
      add :home, :integer
      add :visit, :integer
      add :league, :integer

      timestamps()
    end


    create index(:basketball_games, [:home, :visit, :league], unique: true)
  end
end
