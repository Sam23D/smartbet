defmodule Smartbet.SportsTest do
  use Smartbet.DataCase

  alias Smartbet.Sports

  describe "basketball_teams" do
    alias Smartbet.Sports.BasketballTeam

    @valid_attrs %{logo_imgurl: "some logo_imgurl", name: "some name", national: true, source_id: 42}
    @update_attrs %{logo_imgurl: "some updated logo_imgurl", name: "some updated name", national: false, source_id: 43}
    @invalid_attrs %{logo_imgurl: nil, name: nil, national: nil, source_id: nil}

    def basketball_team_fixture(attrs \\ %{}) do
      {:ok, basketball_team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sports.create_basketball_team()

      basketball_team
    end

    test "list_basketball_teams/0 returns all basketball_teams" do
      basketball_team = basketball_team_fixture()
      assert Sports.list_basketball_teams() == [basketball_team]
    end

    test "get_basketball_team!/1 returns the basketball_team with given id" do
      basketball_team = basketball_team_fixture()
      assert Sports.get_basketball_team!(basketball_team.id) == basketball_team
    end

    test "create_basketball_team/1 with valid data creates a basketball_team" do
      assert {:ok, %BasketballTeam{} = basketball_team} = Sports.create_basketball_team(@valid_attrs)
      assert basketball_team.logo_imgurl == "some logo_imgurl"
      assert basketball_team.name == "some name"
      assert basketball_team.national == true
      assert basketball_team.source_id == 42
    end

    test "create_basketball_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sports.create_basketball_team(@invalid_attrs)
    end

    test "update_basketball_team/2 with valid data updates the basketball_team" do
      basketball_team = basketball_team_fixture()
      assert {:ok, %BasketballTeam{} = basketball_team} = Sports.update_basketball_team(basketball_team, @update_attrs)
      assert basketball_team.logo_imgurl == "some updated logo_imgurl"
      assert basketball_team.name == "some updated name"
      assert basketball_team.national == false
      assert basketball_team.source_id == 43
    end

    test "update_basketball_team/2 with invalid data returns error changeset" do
      basketball_team = basketball_team_fixture()
      assert {:error, %Ecto.Changeset{}} = Sports.update_basketball_team(basketball_team, @invalid_attrs)
      assert basketball_team == Sports.get_basketball_team!(basketball_team.id)
    end

    test "delete_basketball_team/1 deletes the basketball_team" do
      basketball_team = basketball_team_fixture()
      assert {:ok, %BasketballTeam{}} = Sports.delete_basketball_team(basketball_team)
      assert_raise Ecto.NoResultsError, fn -> Sports.get_basketball_team!(basketball_team.id) end
    end

    test "change_basketball_team/1 returns a basketball_team changeset" do
      basketball_team = basketball_team_fixture()
      assert %Ecto.Changeset{} = Sports.change_basketball_team(basketball_team)
    end
  end

  describe "basketball_leagues" do
    alias Smartbet.Sports.BasketballLeage

    @valid_attrs %{logo_imgurl: "some logo_imgurl", name: "some name", seasons: %{}, source_id: 42, type: "some type"}
    @update_attrs %{logo_imgurl: "some updated logo_imgurl", name: "some updated name", seasons: %{}, source_id: 43, type: "some updated type"}
    @invalid_attrs %{logo_imgurl: nil, name: nil, seasons: nil, source_id: nil, type: nil}

    def basketball_leage_fixture(attrs \\ %{}) do
      {:ok, basketball_leage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sports.create_basketball_leage()

      basketball_leage
    end

    test "list_basketball_leagues/0 returns all basketball_leagues" do
      basketball_leage = basketball_leage_fixture()
      assert Sports.list_basketball_leagues() == [basketball_leage]
    end

    test "get_basketball_leage!/1 returns the basketball_leage with given id" do
      basketball_leage = basketball_leage_fixture()
      assert Sports.get_basketball_leage!(basketball_leage.id) == basketball_leage
    end

    test "create_basketball_leage/1 with valid data creates a basketball_leage" do
      assert {:ok, %BasketballLeage{} = basketball_leage} = Sports.create_basketball_leage(@valid_attrs)
      assert basketball_leage.logo_imgurl == "some logo_imgurl"
      assert basketball_leage.name == "some name"
      assert basketball_leage.seasons == %{}
      assert basketball_leage.source_id == 42
      assert basketball_leage.type == "some type"
    end

    test "create_basketball_leage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sports.create_basketball_leage(@invalid_attrs)
    end

    test "update_basketball_leage/2 with valid data updates the basketball_leage" do
      basketball_leage = basketball_leage_fixture()
      assert {:ok, %BasketballLeage{} = basketball_leage} = Sports.update_basketball_leage(basketball_leage, @update_attrs)
      assert basketball_leage.logo_imgurl == "some updated logo_imgurl"
      assert basketball_leage.name == "some updated name"
      assert basketball_leage.seasons == %{}
      assert basketball_leage.source_id == 43
      assert basketball_leage.type == "some updated type"
    end

    test "update_basketball_leage/2 with invalid data returns error changeset" do
      basketball_leage = basketball_leage_fixture()
      assert {:error, %Ecto.Changeset{}} = Sports.update_basketball_leage(basketball_leage, @invalid_attrs)
      assert basketball_leage == Sports.get_basketball_leage!(basketball_leage.id)
    end

    test "delete_basketball_leage/1 deletes the basketball_leage" do
      basketball_leage = basketball_leage_fixture()
      assert {:ok, %BasketballLeage{}} = Sports.delete_basketball_leage(basketball_leage)
      assert_raise Ecto.NoResultsError, fn -> Sports.get_basketball_leage!(basketball_leage.id) end
    end

    test "change_basketball_leage/1 returns a basketball_leage changeset" do
      basketball_leage = basketball_leage_fixture()
      assert %Ecto.Changeset{} = Sports.change_basketball_leage(basketball_leage)
    end
  end

  describe "countries" do
    alias Smartbet.Sports.Country

    @valid_attrs %{code: "some code", flag_imgurl: "some flag_imgurl", id: 42, name: "some name"}
    @update_attrs %{code: "some updated code", flag_imgurl: "some updated flag_imgurl", id: 43, name: "some updated name"}
    @invalid_attrs %{code: nil, flag_imgurl: nil, id: nil, name: nil}

    def country_fixture(attrs \\ %{}) do
      {:ok, country} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sports.create_country()

      country
    end

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Sports.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Sports.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      assert {:ok, %Country{} = country} = Sports.create_country(@valid_attrs)
      assert country.code == "some code"
      assert country.flag_imgurl == "some flag_imgurl"
      assert country.id == 42
      assert country.name == "some name"
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sports.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      assert {:ok, %Country{} = country} = Sports.update_country(country, @update_attrs)
      assert country.code == "some updated code"
      assert country.flag_imgurl == "some updated flag_imgurl"
      assert country.id == 43
      assert country.name == "some updated name"
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Sports.update_country(country, @invalid_attrs)
      assert country == Sports.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Sports.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Sports.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Sports.change_country(country)
    end
  end
end
