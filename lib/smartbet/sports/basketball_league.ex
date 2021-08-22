defmodule Smartbet.Sports.BasketballLeague do
  use Ecto.Schema
  import Ecto.Changeset

  schema "basketball_leagues" do
    field :logo_imgurl, :string
    field :name, :string
    field :seasons, {:array, :map}
    field :type, :string
    field :source_id, :integer
    field :api_source, :string

    timestamps()
  end

  @doc """
  takes a map and a list of key translations and returns a new map with new translations with new keys old values, and old keys deleted
  iex> patch_params(%{ "id" => 1, "attr" => "same" }, params, [{"id", "source_id"}])
  iex> %{ "source_id" => 1, "attr" => "same" }
  """
  # TODO finish implement
  def patch_params(params, change_keys)do
    change_keys
    |> Enum.reduce(params, fn
       {from, to_key}, params_acc ->
          if Map.has_key?(params_acc, from) do
            params_acc
            |> Map.put_new(from, params[from])
            |> Map.delete(from)
          else
            params_acc # pass params as is
          end
      end)
  end
  @doc false
  def changeset(basketball_leage, attrs) do
    params = patch_params(attrs, [{"id", "source_id"}, {"logo", "logo_imgurl"}])
    basketball_leage
    |> cast(params, [:logo_imgurl, :source_id, :name, :type, :seasons])
    |> validate_required([:logo_imgurl, :source_id, :name, :type, :seasons])
  end
end
