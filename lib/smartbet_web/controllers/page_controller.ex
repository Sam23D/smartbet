defmodule SmartbetWeb.PageController do
  use SmartbetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
