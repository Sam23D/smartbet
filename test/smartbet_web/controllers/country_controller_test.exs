defmodule SmartbetWeb.CountryControllerTest do
  use SmartbetWeb.ConnCase

  alias Smartbet.Sports

  @create_attrs %{code: "some code", flag_imgurl: "some flag_imgurl", id: 42, name: "some name"}
  @update_attrs %{code: "some updated code", flag_imgurl: "some updated flag_imgurl", id: 43, name: "some updated name"}
  @invalid_attrs %{code: nil, flag_imgurl: nil, id: nil, name: nil}

  def fixture(:country) do
    {:ok, country} = Sports.create_country(@create_attrs)
    country
  end

  describe "index" do
    test "lists all countries", %{conn: conn} do
      conn = get(conn, Routes.country_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Countries"
    end
  end

  describe "new country" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.country_path(conn, :new))
      assert html_response(conn, 200) =~ "New Country"
    end
  end

  describe "create country" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.country_path(conn, :create), country: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.country_path(conn, :show, id)

      conn = get(conn, Routes.country_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Country"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.country_path(conn, :create), country: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Country"
    end
  end

  describe "edit country" do
    setup [:create_country]

    test "renders form for editing chosen country", %{conn: conn, country: country} do
      conn = get(conn, Routes.country_path(conn, :edit, country))
      assert html_response(conn, 200) =~ "Edit Country"
    end
  end

  describe "update country" do
    setup [:create_country]

    test "redirects when data is valid", %{conn: conn, country: country} do
      conn = put(conn, Routes.country_path(conn, :update, country), country: @update_attrs)
      assert redirected_to(conn) == Routes.country_path(conn, :show, country)

      conn = get(conn, Routes.country_path(conn, :show, country))
      assert html_response(conn, 200) =~ "some updated code"
    end

    test "renders errors when data is invalid", %{conn: conn, country: country} do
      conn = put(conn, Routes.country_path(conn, :update, country), country: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Country"
    end
  end

  describe "delete country" do
    setup [:create_country]

    test "deletes chosen country", %{conn: conn, country: country} do
      conn = delete(conn, Routes.country_path(conn, :delete, country))
      assert redirected_to(conn) == Routes.country_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.country_path(conn, :show, country))
      end
    end
  end

  defp create_country(_) do
    country = fixture(:country)
    %{country: country}
  end
end
