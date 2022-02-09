defmodule SmartbetWeb.Components.Huro do
  use Phoenix.Component
  import Phoenix.HTML.Form

  def side_panel(assigns) do
    ~H"""
    side panel
    """
  end

  # def pagination(%{ page_number: pn, page_size: ps, total_entries: te, total_pages: tp }) do
  def pagination(assigns) do
    _pagination(assigns.user_bets, assigns)
  end

  defp _pagination(%{page_number: pn, total_pages: tp}, assigns) when pn == tp do
    prev = "?page=#{pn - 1}"
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

  defp _pagination(%{page_number: pn, total_pages: tp}, assigns) when pn == 1 do
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

  defp _pagination(%{page_number: pn, total_pages: tp}, assigns) do
    prev = "?page=#{pn - 1}"
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

  def bet_today_games(assigns) do
    IO.inspect(assigns, label: "BET FROM TODAY GAMES")
    ~H"""
    <div class="dashboard-card is-side stock-card">
      <div class="action-bar is-justify-content-space-between">
            <h3>Track New Bets</h3>
            <div class="select">
              <%= select nil, :game_league, Enum.map(@tracked_leagues, &{ &1.name, &1.id }) %>
            </div>


        <label for="date-bet" class="button is-info">
            <span class="icon is-small">
                  <i class="fas fa-calendar"></i>
            </span>
        </label>
        <input name="date-bet" id="date-bet" type="date"  >

        </div>
      <div class="stock">
            <div class="h-avatar is-small">
              <img class="avatar is-squared" src="assets/img/logos/nba/lakers.png" alt="">
            </div>
        <div class="stock-value"><a class="button h-button is-success is-light">+10</a></div>
        <div class="stock-value"><a class="button h-button is-info is-light">o220</a></div>
        <div class="stock-value"><a class="button h-button is-warning is-light">-110</a></div>
      </div>
      <div class="stock">
            <div class="h-avatar is-small">
              <img class="avatar is-squared" src="assets/img/logos/nba/suns.png" alt="">
            </div>
            <div class="stock-value"><a class="button h-button is-success is-light">+10</a></div>
            <div class="stock-value"><a class="button h-button is-info is-light">o220</a></div>
            <div class="stock-value"><a class="button h-button is-warning is-light">-110</a></div>
        </div>
        <div class="p-2"></div>
        <div class="stock">
            <div class="h-avatar is-small">
              <img class="avatar is-squared" src="assets/img/logos/nba/mavericks.png" alt="">
            </div>
            <div class="stock-value"><a class="button h-button is-success is-light">+10</a></div>
            <div class="stock-value"><a class="button h-button is-info is-light">o220</a></div>
            <div class="stock-value"><a class="button h-button is-warning is-light">-110</a></div>
        </div>
        <div class="stock">
            <div class="h-avatar is-small">
              <img class="avatar is-squared" src="assets/img/logos/nba/spurs.png" alt="">
            </div>
            <div class="stock-value"><a class="button h-button is-success is-light">+10</a></div>
            <div class="stock-value"><a class="button h-button is-info is-light">o220</a></div>
            <div class="stock-value"><a class="button h-button is-warning is-light">-110</a></div>
        </div>
    </div>
    """
  end
end
