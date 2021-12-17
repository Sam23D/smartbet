defmodule Smartbet.GenericChangesets do
  alias Ecto.Changeset

  alias Smartbet.GenericChangesets.LeagueSearchInput
  alias Smartbet.GenericChangesets.GenSearchParams

  def league_serch_input_changeset(params) do
    types = %{league_name: :string}
    data  = %LeagueSearchInput{}
    {data, types}
    |> Changeset.cast(params, Map.keys(types))
  end

  def generic_search_params_filters_changeset(params) do
    types = %{query: :string, as: :string}
    data  = %GenSearchParams{}
    {data, types}
    |> Changeset.cast(params, [:query, :as])
  end

end
