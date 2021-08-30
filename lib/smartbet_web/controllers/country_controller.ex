defmodule SmartbetWeb.CountryController do
  use SmartbetWeb, :controller

  alias Smartbet.Sports
  alias Smartbet.Sports.Country

  def index(conn, _params) do
    countries = Sports.list_countries()
    render(conn, "index.html", countries: countries)
  end

  def new(conn, _params) do
    changeset = Sports.change_country(%Country{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"country" => country_params}) do
    case Sports.create_country(country_params) do
      {:ok, country} ->
        conn
        |> put_flash(:info, "Country created successfully.")
        |> redirect(to: Routes.country_path(conn, :show, country))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    country = Sports.get_country!(id)
    render(conn, "show.html", country: country)
  end

  def edit(conn, %{"id" => id}) do
    country = Sports.get_country!(id)
    changeset = Sports.change_country(country)
    render(conn, "edit.html", country: country, changeset: changeset)
  end

  def update(conn, %{"id" => id, "country" => country_params}) do
    country = Sports.get_country!(id)

    case Sports.update_country(country, country_params) do
      {:ok, country} ->
        conn
        |> put_flash(:info, "Country updated successfully.")
        |> redirect(to: Routes.country_path(conn, :show, country))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", country: country, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    country = Sports.get_country!(id)
    {:ok, _country} = Sports.delete_country(country)

    conn
    |> put_flash(:info, "Country deleted successfully.")
    |> redirect(to: Routes.country_path(conn, :index))
  end
end
