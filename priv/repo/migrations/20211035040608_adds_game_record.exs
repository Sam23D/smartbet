defmodule Smartbet.Repo.Migrations.AddsGameRecord do
  use Ecto.Migration

  @moduledoc """
  This schema will represent the data extracted from an API for an app, and will act as an event store
  for the game state, and how it will change over the match
  """

  def change do
    create table(:basketball_game_records)do
      add :game_data, :map
      add :game_headline, :string

      add :game_id, references(:basketball_games)
      timestamps()
    end


    create index(:basketball_game_records, [:game_id])
  end

end
