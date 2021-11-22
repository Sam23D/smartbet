defmodule SmartbetWeb.AdminConsoleLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    ADMIN LIVE CONSOLE
    """
  end

  def mount(_params, socket) do
    IO.inspect("ON MUNT")
    {:ok, socket}
  end

end
