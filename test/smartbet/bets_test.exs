defmodule Smartbet.BetsTest do
  use Smartbet.DataCase

  alias Smartbet.Bets

  describe "user_bets" do
    alias Smartbet.Bets.UserBets

    @valid_attrs %{amount: "120.5", bet_result: "some bet_result", details: "some details", event_headline: "some event_headline", line: "120.5", platform: "some platform", profit: "120.5", sport: "some sport"}
    @update_attrs %{amount: "456.7", bet_result: "some updated bet_result", details: "some updated details", event_headline: "some updated event_headline", line: "456.7", platform: "some updated platform", profit: "456.7", sport: "some updated sport"}
    @invalid_attrs %{amount: nil, bet_result: nil, details: nil, event_headline: nil, line: nil, platform: nil, profit: nil, sport: nil}

    def user_bets_fixture(attrs \\ %{}) do
      {:ok, user_bets} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bets.create_user_bets()

      user_bets
    end

    test "list_user_bets/0 returns all user_bets" do
      user_bets = user_bets_fixture()
      assert Bets.list_user_bets() == [user_bets]
    end

    test "get_user_bets!/1 returns the user_bets with given id" do
      user_bets = user_bets_fixture()
      assert Bets.get_user_bets!(user_bets.id) == user_bets
    end

    test "create_user_bets/1 with valid data creates a user_bets" do
      assert {:ok, %UserBets{} = user_bets} = Bets.create_user_bets(@valid_attrs)
      assert user_bets.amount == Decimal.new("120.5")
      assert user_bets.bet_result == "some bet_result"
      assert user_bets.details == "some details"
      assert user_bets.event_headline == "some event_headline"
      assert user_bets.line == Decimal.new("120.5")
      assert user_bets.platform == "some platform"
      assert user_bets.profit == Decimal.new("120.5")
      assert user_bets.sport == "some sport"
    end

    test "create_user_bets/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bets.create_user_bets(@invalid_attrs)
    end

    test "update_user_bets/2 with valid data updates the user_bets" do
      user_bets = user_bets_fixture()
      assert {:ok, %UserBets{} = user_bets} = Bets.update_user_bets(user_bets, @update_attrs)
      assert user_bets.amount == Decimal.new("456.7")
      assert user_bets.bet_result == "some updated bet_result"
      assert user_bets.details == "some updated details"
      assert user_bets.event_headline == "some updated event_headline"
      assert user_bets.line == Decimal.new("456.7")
      assert user_bets.platform == "some updated platform"
      assert user_bets.profit == Decimal.new("456.7")
      assert user_bets.sport == "some updated sport"
    end

    test "update_user_bets/2 with invalid data returns error changeset" do
      user_bets = user_bets_fixture()
      assert {:error, %Ecto.Changeset{}} = Bets.update_user_bets(user_bets, @invalid_attrs)
      assert user_bets == Bets.get_user_bets!(user_bets.id)
    end

    test "delete_user_bets/1 deletes the user_bets" do
      user_bets = user_bets_fixture()
      assert {:ok, %UserBets{}} = Bets.delete_user_bets(user_bets)
      assert_raise Ecto.NoResultsError, fn -> Bets.get_user_bets!(user_bets.id) end
    end

    test "change_user_bets/1 returns a user_bets changeset" do
      user_bets = user_bets_fixture()
      assert %Ecto.Changeset{} = Bets.change_user_bets(user_bets)
    end
  end
end
