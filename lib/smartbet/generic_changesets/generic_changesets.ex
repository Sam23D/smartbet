defmodule Smartbet.GenericChangesets do
  alias Ecto.Changeset

  alias Smartbet.GenericChangesets.LeagueSearchInput

  def league_serch_input_changeset(params) do
    types = %{league_name: :string}
    data  = %LeagueSearchInput{}
    {data, types}
    |> Changeset.cast(params, Map.keys(types))
  end

end
