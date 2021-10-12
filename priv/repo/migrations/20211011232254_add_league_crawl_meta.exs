defmodule Smartbet.Repo.Migrations.AddLeagueCrawlMeta do
  use Ecto.Migration

  def change do
    alter table "basketball_leagues" do
      add :crawl_meta, :map

    end
  end

end
