defmodule SmartbetWeb.UserBetsControllerTest do
  use SmartbetWeb.ConnCase

  alias Smartbet.Bets

  @create_attrs %{amount: "120.5", bet_result: "some bet_result", details: "some details", event_headline: "some event_headline", line: "120.5", platform: "some platform", profit: "120.5", sport: "some sport"}
  @update_attrs %{amount: "456.7", bet_result: "some updated bet_result", details: "some updated details", event_headline: "some updated event_headline", line: "456.7", platform: "some updated platform", profit: "456.7", sport: "some updated sport"}
  @invalid_attrs %{amount: nil, bet_result: nil, details: nil, event_headline: nil, line: nil, platform: nil, profit: nil, sport: nil}

  def fixture(:user_bets) do
    {:ok, user_bets} = Bets.create_user_bets(@create_attrs)
    user_bets
  end

  describe "index" do
    test "lists all user_bets", %{conn: conn} do
      conn = get(conn, Routes.user_bets_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing User bets"
    end
  end

  describe "new user_bets" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_bets_path(conn, :new))
      assert html_response(conn, 200) =~ "New User bets"
    end
  end

  describe "create user_bets" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_bets_path(conn, :create), user_bets: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_bets_path(conn, :show, id)

      conn = get(conn, Routes.user_bets_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User bets"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_bets_path(conn, :create), user_bets: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User bets"
    end
  end

  describe "edit user_bets" do
    setup [:create_user_bets]

    test "renders form for editing chosen user_bets", %{conn: conn, user_bets: user_bets} do
      conn = get(conn, Routes.user_bets_path(conn, :edit, user_bets))
      assert html_response(conn, 200) =~ "Edit User bets"
    end
  end

  describe "update user_bets" do
    setup [:create_user_bets]

    test "redirects when data is valid", %{conn: conn, user_bets: user_bets} do
      conn = put(conn, Routes.user_bets_path(conn, :update, user_bets), user_bets: @update_attrs)
      assert redirected_to(conn) == Routes.user_bets_path(conn, :show, user_bets)

      conn = get(conn, Routes.user_bets_path(conn, :show, user_bets))
      assert html_response(conn, 200) =~ "some updated bet_result"
    end

    test "renders errors when data is invalid", %{conn: conn, user_bets: user_bets} do
      conn = put(conn, Routes.user_bets_path(conn, :update, user_bets), user_bets: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User bets"
    end
  end

  describe "delete user_bets" do
    setup [:create_user_bets]

    test "deletes chosen user_bets", %{conn: conn, user_bets: user_bets} do
      conn = delete(conn, Routes.user_bets_path(conn, :delete, user_bets))
      assert redirected_to(conn) == Routes.user_bets_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.user_bets_path(conn, :show, user_bets))
      end
    end
  end

  defp create_user_bets(_) do
    user_bets = fixture(:user_bets)
    %{user_bets: user_bets}
  end
end
