defmodule Smartbet.Sports.DataFetcher do
  alias Smartbet.Outbound.SportsAPIBasketball

  @moduledoc """
  This module should be used for accesing data from other internal modules. DataFetcher should syphon many data sources
  into a single source of truth for the system

  """

  def configuration()do
    %{ basketball: [
        api: [ SportsAPIBasketballFetcher ]
      ]
    }
  end

  @doc """
  """
  @spec fetch_all_teams(any, any) :: any
  def fetch_all_teams(source, sport \\ :basketball )do
    configuration()
    # TODO change to accept sport instead of :basketball when more modules are finished
    |> get_in([ :basketball, :api ])

  end

  # TODO define fetch all leagues

  # TODO define fetch all countries
  # should return all countries in the db

end
