defmodule SmartbetWeb.BasketballLeageControllerTest do
  use SmartbetWeb.ConnCase

  alias Smartbet.Sports

  @create_attrs %{logo_imgurl: "some logo_imgurl", name: "some name", seasons: %{}, source_id: 42, type: "some type"}
  @update_attrs %{logo_imgurl: "some updated logo_imgurl", name: "some updated name", seasons: %{}, source_id: 43, type: "some updated type"}
  @invalid_attrs %{logo_imgurl: nil, name: nil, seasons: nil, source_id: nil, type: nil}

  def fixture(:basketball_leage) do
    {:ok, basketball_leage} = Sports.create_basketball_leage(@create_attrs)
    basketball_leage
  end

  describe "index" do
    test "lists all basketball_leagues", %{conn: conn} do
      conn = get(conn, Routes.basketball_leage_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Basketball leagues"
    end
  end

  describe "new basketball_leage" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.basketball_leage_path(conn, :new))
      assert html_response(conn, 200) =~ "New Basketball leage"
    end
  end

  describe "create basketball_leage" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.basketball_leage_path(conn, :create), basketball_leage: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.basketball_leage_path(conn, :show, id)

      conn = get(conn, Routes.basketball_leage_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Basketball leage"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.basketball_leage_path(conn, :create), basketball_leage: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Basketball leage"
    end
  end

  describe "edit basketball_leage" do
    setup [:create_basketball_leage]

    test "renders form for editing chosen basketball_leage", %{conn: conn, basketball_leage: basketball_leage} do
      conn = get(conn, Routes.basketball_leage_path(conn, :edit, basketball_leage))
      assert html_response(conn, 200) =~ "Edit Basketball leage"
    end
  end

  describe "update basketball_leage" do
    setup [:create_basketball_leage]

    test "redirects when data is valid", %{conn: conn, basketball_leage: basketball_leage} do
      conn = put(conn, Routes.basketball_leage_path(conn, :update, basketball_leage), basketball_leage: @update_attrs)
      assert redirected_to(conn) == Routes.basketball_leage_path(conn, :show, basketball_leage)

      conn = get(conn, Routes.basketball_leage_path(conn, :show, basketball_leage))
      assert html_response(conn, 200) =~ "some updated logo_imgurl"
    end

    test "renders errors when data is invalid", %{conn: conn, basketball_leage: basketball_leage} do
      conn = put(conn, Routes.basketball_leage_path(conn, :update, basketball_leage), basketball_leage: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Basketball leage"
    end
  end

  describe "delete basketball_leage" do
    setup [:create_basketball_leage]

    test "deletes chosen basketball_leage", %{conn: conn, basketball_leage: basketball_leage} do
      conn = delete(conn, Routes.basketball_leage_path(conn, :delete, basketball_leage))
      assert redirected_to(conn) == Routes.basketball_leage_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.basketball_leage_path(conn, :show, basketball_leage))
      end
    end
  end

  defp create_basketball_leage(_) do
    basketball_leage = fixture(:basketball_leage)
    %{basketball_leage: basketball_leage}
  end
end
