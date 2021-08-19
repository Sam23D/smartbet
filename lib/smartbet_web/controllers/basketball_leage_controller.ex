defmodule SmartbetWeb.BasketballLeageController do
  use SmartbetWeb, :controller

  alias Smartbet.Sports
  alias Smartbet.Sports.BasketballLeage

  def index(conn, _params) do
    basketball_leagues = Sports.list_basketball_leagues()
    render(conn, "index.html", basketball_leagues: basketball_leagues)
  end

  def new(conn, _params) do
    changeset = Sports.change_basketball_leage(%BasketballLeage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"basketball_leage" => basketball_leage_params}) do
    case Sports.create_basketball_leage(basketball_leage_params) do
      {:ok, basketball_leage} ->
        conn
        |> put_flash(:info, "Basketball leage created successfully.")
        |> redirect(to: Routes.basketball_leage_path(conn, :show, basketball_leage))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    basketball_leage = Sports.get_basketball_leage!(id)
    render(conn, "show.html", basketball_leage: basketball_leage)
  end

  def edit(conn, %{"id" => id}) do
    basketball_leage = Sports.get_basketball_leage!(id)
    changeset = Sports.change_basketball_leage(basketball_leage)
    render(conn, "edit.html", basketball_leage: basketball_leage, changeset: changeset)
  end

  def update(conn, %{"id" => id, "basketball_leage" => basketball_leage_params}) do
    basketball_leage = Sports.get_basketball_leage!(id)

    case Sports.update_basketball_leage(basketball_leage, basketball_leage_params) do
      {:ok, basketball_leage} ->
        conn
        |> put_flash(:info, "Basketball leage updated successfully.")
        |> redirect(to: Routes.basketball_leage_path(conn, :show, basketball_leage))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", basketball_leage: basketball_leage, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    basketball_leage = Sports.get_basketball_leage!(id)
    {:ok, _basketball_leage} = Sports.delete_basketball_leage(basketball_leage)

    conn
    |> put_flash(:info, "Basketball leage deleted successfully.")
    |> redirect(to: Routes.basketball_leage_path(conn, :index))
  end
end
