defmodule SmartbetWeb.BasketballTeamController do
  use SmartbetWeb, :controller

  alias Smartbet.Sports
  alias Smartbet.Sports.BasketballTeam

  def index(conn, _params) do
    basketball_teams = Sports.list_basketball_teams()
    render(conn, "index.html", basketball_teams: basketball_teams)
  end

  def new(conn, _params) do
    changeset = Sports.change_basketball_team(%BasketballTeam{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"basketball_team" => basketball_team_params}) do
    case Sports.create_basketball_team(basketball_team_params) do
      {:ok, basketball_team} ->
        conn
        |> put_flash(:info, "Basketball team created successfully.")
        |> redirect(to: Routes.basketball_team_path(conn, :show, basketball_team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    basketball_team = Sports.get_basketball_team!(id)
    render(conn, "show.html", basketball_team: basketball_team)
  end

  def edit(conn, %{"id" => id}) do
    basketball_team = Sports.get_basketball_team!(id)
    changeset = Sports.change_basketball_team(basketball_team)
    render(conn, "edit.html", basketball_team: basketball_team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "basketball_team" => basketball_team_params}) do
    basketball_team = Sports.get_basketball_team!(id)

    case Sports.update_basketball_team(basketball_team, basketball_team_params) do
      {:ok, basketball_team} ->
        conn
        |> put_flash(:info, "Basketball team updated successfully.")
        |> redirect(to: Routes.basketball_team_path(conn, :show, basketball_team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", basketball_team: basketball_team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    basketball_team = Sports.get_basketball_team!(id)
    {:ok, _basketball_team} = Sports.delete_basketball_team(basketball_team)

    conn
    |> put_flash(:info, "Basketball team deleted successfully.")
    |> redirect(to: Routes.basketball_team_path(conn, :index))
  end
end
