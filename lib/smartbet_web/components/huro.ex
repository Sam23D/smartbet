defmodule SmartbetWeb.Components.Huro do
  use Phoenix.Component

  def side_panel(assigns) do
    ~H"""
    side panel
    """
  end

  #def pagination(%{ page_number: pn, page_size: ps, total_entries: te, total_pages: tp }) do
  def pagination(assigns) do
    ~H"""
    pagination, total: <%= @user_bets.page_number %>
    page_size: <%= @user_bets.page_size %>
    total_entries: <%= @user_bets.total_entries %>
    total_pages: <%= @user_bets.total_pages %>
    """
  end


end
