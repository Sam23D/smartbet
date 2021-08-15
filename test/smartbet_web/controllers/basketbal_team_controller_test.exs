defmodule SmartbetWeb.BasketballTeamControllerTest do
  use SmartbetWeb.ConnCase

  alias Smartbet.Sports

  @create_attrs %{logo_imgurl: "some logo_imgurl", name: "some name", national: true, source_id: 42}
  @update_attrs %{logo_imgurl: "some updated logo_imgurl", name: "some updated name", national: false, source_id: 43}
  @invalid_attrs %{logo_imgurl: nil, name: nil, national: nil, source_id: nil}

  def fixture(:basketball_team) do
    {:ok, basketball_team} = Sports.create_basketball_team(@create_attrs)
    basketball_team
  end

  describe "index" do
    test "lists all basketball_teams", %{conn: conn} do
      conn = get(conn, Routes.basketball_team_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Basketball teams"
    end
  end

  describe "new basketball_team" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.basketball_team_path(conn, :new))
      assert html_response(conn, 200) =~ "New Basketball team"
    end
  end

  describe "create basketball_team" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.basketball_team_path(conn, :create), basketball_team: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.basketball_team_path(conn, :show, id)

      conn = get(conn, Routes.basketball_team_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Basketball team"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.basketball_team_path(conn, :create), basketball_team: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Basketball team"
    end
  end

  describe "edit basketball_team" do
    setup [:create_basketball_team]

    test "renders form for editing chosen basketball_team", %{conn: conn, basketball_team: basketball_team} do
      conn = get(conn, Routes.basketball_team_path(conn, :edit, basketball_team))
      assert html_response(conn, 200) =~ "Edit Basketball team"
    end
  end

  describe "update basketball_team" do
    setup [:create_basketball_team]

    test "redirects when data is valid", %{conn: conn, basketball_team: basketball_team} do
      conn = put(conn, Routes.basketball_team_path(conn, :update, basketball_team), basketball_team: @update_attrs)
      assert redirected_to(conn) == Routes.basketball_team_path(conn, :show, basketball_team)

      conn = get(conn, Routes.basketball_team_path(conn, :show, basketball_team))
      assert html_response(conn, 200) =~ "some updated logo_imgurl"
    end

    test "renders errors when data is invalid", %{conn: conn, basketball_team: basketball_team} do
      conn = put(conn, Routes.basketball_team_path(conn, :update, basketball_team), basketball_team: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Basketball team"
    end
  end

  describe "delete basketball_team" do
    setup [:create_basketball_team]

    test "deletes chosen basketball_team", %{conn: conn, basketball_team: basketball_team} do
      conn = delete(conn, Routes.basketball_team_path(conn, :delete, basketball_team))
      assert redirected_to(conn) == Routes.basketball_team_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.basketball_team_path(conn, :show, basketball_team))
      end
    end
  end

  defp create_basketball_team(_) do
    basketball_team = fixture(:basketball_team)
    %{basketball_team: basketball_team}
  end
end
