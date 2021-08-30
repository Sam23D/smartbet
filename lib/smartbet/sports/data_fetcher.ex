defmodule Smartbet.Sports.DataFetcher do
  alias Smartbet.Outbound.SportsAPIBasketball
  alias Smartbet.Outbound.SportsAPIBasketballFetcher


  @moduledoc """
  Use this module to fetch all information related to sports, such as game results, leagues, teams, countries, and sports supported by the system

  This module will centralize all other modules and API implementations currently it has:
  Sources/ APIS:
  - SportsAPI

  Sports
  - Basketball [ SportsAPI ]
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
    #TODO do fancy logic to fetch from diferent sources specified in configuration()
    #TODO specify more leagues and not just 12 (NBA)
    SportsAPIBasketballFetcher.fetch_teams( 12, "2020-2021" )
  end

  defdelegate fetch_all_leagues(search_params \\ %{}, from \\ :db_cache), to: SportsAPIBasketballFetcher

  defdelegate fetch_all_countries(from \\ :db_cache), to: SportsAPIBasketballFetcher

  # TODO define fetch all countries
  # should return all countries in the db

end
