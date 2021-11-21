defmodule Smartbet.Sports.Crawler do

  alias Smartbet.Outbound.SportsAPIBasketballFetcher

  @moduledoc """
  This module provides functionality to keep track of games, such as daily crawling
  game score tracking and more



  """



  @doc """
  Usually run this crawl when starting a new server
  """
  def setup_crawl_sport do
    # crawls leagues for given sport
    with countries <- SportsAPIBasketballFetcher.fetch_all_countries(:fetch_api),
      leagues <- SportsAPIBasketballFetcher.fetch_all_leagues( %{}, :fetch_api),
      # map a list instead of 12 for crawling multiple leagues on startup
      teams <- SportsAPIBasketballFetcher.fetch_teams( 12, :fetch_api)
    do
      IO.inspect("Fetched #{ Enum.count(countries) } Countries")
      IO.inspect("Fetched #{ Enum.count(leagues) } Leagues")
      IO.inspect(teams)

    end
  end

  @doc """

  """
  def daily_crawl do
    # get games that have today as crawling day ( we will be configuring jobs along the day for a given game )
    # add as many leagues as desired to crawl games for...
    SportsAPIBasketballFetcher.fetch_games(:today, 12)
  end

  @doc """


  crawl_game(%{ source_id: source_id })
  """
  def crawl_game() do
   # crawls game, creates updates game
   # creates game_record
   # sends required notifications
  end


end
