defmodule SmartbetWeb.Components.Huro do
  use Phoenix.Component

  def side_panel(assigns) do
    ~H"""
    side panel
    """
  end

  #def pagination(%{ page_number: pn, page_size: ps, total_entries: te, total_pages: tp }) do
  def pagination(assigns) do
    _pagination(assigns.user_bets, assigns)
  end

  defp _pagination(%{page_number: pn, total_pages: tp}, assigns) when pn == tp  do
    prev =  "?page=#{pn - 1}"
    final = "?page=#{tp}"

    ~H"""
    <nav class="flex-pagination pagination is-rounded" aria-label="pagination" data-filter-hide>
      <a href={prev} class="pagination-previous has-chevron"><i data-feather="chevron-left"></i></a>
      <ul class="pagination-list">
        <li><a href="?page=1" class="pagination-link" aria-label="Goto page 1">1</a></li>
        <li><span class="pagination-ellipsis">…</span></li>
        <li><a href={final} class="pagination-link is-current" aria-label="Page 46" aria-current="page"><%= @user_bets.page_number %></a>
        </li>
      </ul>
    </nav>
    """
  end

  defp _pagination(%{page_number: pn, total_pages: tp}, assigns) when pn == 1  do
    next = "?page=#{pn + 1}"
    final = "?page=#{tp}"
    ~H"""
    <nav class="flex-pagination pagination is-rounded" aria-label="pagination" data-filter-hide>
      <a href={next} class="pagination-next has-chevron"><i data-feather="chevron-right"></i></a>
      <ul class="pagination-list">
        <li><a  class="pagination-link is-current" aria-label="Page 46" aria-current="page"><%= @user_bets.page_number %></a>
        </li>
        <li><span class="pagination-ellipsis">…</span></li>
        <li><a href={final} class="pagination-link" aria-label="Goto page 86"><%= @user_bets.total_pages %></a></li>
      </ul>
    </nav>
    """
  end

  defp _pagination(%{page_number: pn, total_pages: tp}, assigns)  do
    prev =  "?page=#{pn - 1}"
    next = "?page=#{pn + 1}"
    final = "?page=#{tp}"
    ~H"""
    <nav class="flex-pagination pagination is-rounded" aria-label="pagination" data-filter-hide>
      <a href={prev} class="pagination-previous has-chevron"><i data-feather="chevron-left"></i></a>
      <a href={next} class="pagination-next has-chevron"><i data-feather="chevron-right"></i></a>
      <ul class="pagination-list">
      <li><a href="?page=1" class="pagination-link" aria-label="Goto page 1">1</a></li>
        <li><span class="pagination-ellipsis">…</span></li>
        <li><a class="pagination-link is-current" aria-label="Page 46" aria-current="page"><%= @user_bets.page_number %></a>
        </li>
        <li><span class="pagination-ellipsis">…</span></li>
        <li><a href={final} class="pagination-link" aria-label="Goto page 86"><%= @user_bets.total_pages %></a></li>
      </ul>
    </nav>
    """
  end

end
