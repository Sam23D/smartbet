defmodule Smartbet.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :flag_imgurl, :string
      add :name, :string
      add :code, :string

      timestamps()
    end

    create index(:countries, [:name, :code], unique: true)

  end
end
