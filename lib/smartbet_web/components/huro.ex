defmodule SmartbetWeb.Components.Huro do
  use Phoenix.Component

  def side_panel(assigns) do
    ~H"""
    side panel
    """
  end

  #def pagination(%{ page_number: pn, page_size: ps, total_entries: te, total_pages: tp }) do
  def pagination(%{page: page}=assigns) do
    _pagination(page, assigns)
  end

  defp _pagination_hrefs(%{page_number: pn, total_pages: tp})do
    %{ page_number: "?page=#{pn}", final_page: "?page=#{tp}", prev_page: "?page=#{pn - 1}", next_page: "?page=#{pn + 1}" }
  end

  defp _pagination(%{page_number: pn, total_pages: tp}=page, assigns) when pn == tp and tp == 1  do
    %{ }  = _pagination_hrefs(page)
    ~H"""
    <nav class="flex-pagination pagination is-rounded" aria-label="pagination" data-filter-hide>
      <ul class="pagination-list">
        <li><a class="pagination-link is-current" aria-label="Page 46" aria-current="page"><%= @page.page_number %></a>
        </li>
      </ul>
    </nav>
    """
  end

  defp _pagination(%{page_number: pn, total_pages: tp}=page, assigns) when pn == tp  do
    %{prev_page: prev_href, final_page: final_href }  = _pagination_hrefs(page)
    ~H"""
    <nav class="flex-pagination pagination is-rounded" aria-label="pagination" data-filter-hide>
      <a href={prev_href} class="pagination-previous has-chevron"><i data-feather="chevron-left"></i></a>
      <ul class="pagination-list">
        <li><a href="?page=1" class="pagination-link" aria-label="Goto page 1">1</a></li>
        <li><span class="pagination-ellipsis">…</span></li>
        <li><a href={final_href} class="pagination-link is-current" aria-label="Page 46" aria-current="page"><%= @page.page_number %></a>
        </li>
      </ul>
    </nav>
    """
  end

  defp _pagination(%{page_number: pn, total_pages: tp}=page, assigns) when pn == 1  do
    %{next_page: next_href, final_page: final_href} = _pagination_hrefs(page)
    ~H"""
    <nav class="flex-pagination pagination is-rounded" aria-label="pagination" data-filter-hide>
      <a href={next_href} class="pagination-next has-chevron"><i data-feather="chevron-right"></i></a>
      <ul class="pagination-list">
        <li><a  class="pagination-link is-current" aria-label="Page 46" aria-current="page"><%= @page.page_number %></a>
        </li>
        <li><span class="pagination-ellipsis">…</span></li>
        <li><a href={final_href} class="pagination-link" aria-label="Goto page 86"><%= @page.total_pages %></a></li>
      </ul>
    </nav>
    """
  end

  defp _pagination(%{page_number: pn, total_pages: tp}=page, assigns)  do
    %{next_page: next_href, final_page: final_href, previous_page: prev_href} = _pagination_hrefs(page)
    ~H"""
    <nav class="flex-pagination pagination is-rounded" aria-label="pagination" data-filter-hide>
      <a href={prev_href} class="pagination-previous has-chevron"><i data-feather="chevron-left"></i></a>
      <a href={next_href} class="pagination-next has-chevron"><i data-feather="chevron-right"></i></a>
      <ul class="pagination-list">
      <li><a href="?page=1" class="pagination-link" aria-label="Goto page 1">1</a></li>
        <li><span class="pagination-ellipsis">…</span></li>
        <li><a class="pagination-link is-current" aria-label="Page 46" aria-current="page"><%= @page.page_number %></a>
        </li>
        <li><span class="pagination-ellipsis">…</span></li>
        <li><a href={final_href} class="pagination-link" aria-label="Goto page 86"><%= @page.total_pages %></a></li>
      </ul>
    </nav>
    """
  end

end
