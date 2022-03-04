defmodule SmartbetWeb.Components.Huro do
  use Phoenix.Component
  import Phoenix.HTML.Form

  def side_panel(assigns) do
    ~H"""
    side panel
    """
  end

  @doc """
  <Huro.pagination user_bets= {@user_bets} />
  # def pagination(%{ page_number: pn, page_size: ps, total_entries: te, total_pages: tp }) do
  """
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

  @doc """
  Parameters:
  - tracked_leagues :: list( BasketballLeague )
  - today_games :: list( BasketballGames )
  -

  In a HEEX template:
  <Huro.bet_today_games tracked_leagues={} today_games={}  >
  """
  def bet_today_games(assigns) do

    assigns =
      assigns
      |> assign_new(:today_games, fn -> [] end)

    ~H"""
    <div class="dashboard-card is-side stock-card">
      <div class="card-head">
        <h3 class="has-text-grey-light">Bet on today's games</h3>
      </div>
      <div class="action-bar is-justify-content-space-between">
        <div class="select">
          <%= select nil, :game_league, Enum.map(@tracked_leagues, &{ &1.name, &1.id }) %>
        </div>
        <.dropdown_calendar ></.dropdown_calendar>
      </div>
      <%= if @today_games do %>
        <%= for game <- @today_games do %>
        <div class="stock">
          <div class="h-avatar is-small">
            <img class="avatar is-squared" src={ game.game_data["teams"]["home"]["logo"] } alt="">
          </div>
          <div class="stock-value"><a class="button h-button is-success is-light">+10</a></div>
          <div class="stock-value"><a class="button h-button is-info is-light">o220</a></div>
          <div class="stock-value"><a class="button h-button is-warning is-light">-110</a></div>
        </div>
        <div class="stock">
            <div class="h-avatar is-small">
              <img class="avatar is-squared" src={game.game_data["teams"]["away"]["logo"] } alt="">
            </div>
            <div class="stock-value"><a class="button h-button is-success is-light">+10</a></div>
            <div class="stock-value"><a class="button h-button is-info is-light">o220</a></div>
            <div class="stock-value"><a class="button h-button is-warning is-light">-110</a></div>
        </div>
        <div class="p-2"></div>
      <% end %>
      <% else %>
        <p>No games for today</p>
      <% end %>

    </div>
    """
  end

  def dropdown_calendar(assigns) do
    # TBD how to emit messages to update a selected date on a changeset?
    ~H"""
    <div class="dropdown  is-spaced dropdown-trigger">
               <div class="is-trigger" aria-haspopup="true" aria-controls="dropdown-menu">
                  <button class="button h-button is-primary is-outlined ">
                  <span class="icon">
                  <i class="fas fa-calendar-alt"></i>
                  </span>
                  <span>October 18</span>
                  </button>
               </div>
               <div class="dropdown-menu" role="menu">
                  <div class="dropdown-content widget picker-widget">
                     <div class="widget-toolbar">
                        <div class="left">
                           <a class="action-icon">
                           <i data-feather="chevron-left"></i>
                           </a>
                        </div>
                        <div class="center">
                           <h3>October 2020</h3>
                        </div>
                        <div class="right">
                           <a class="action-icon">
                           <i data-feather="chevron-right"></i>
                           </a>
                        </div>
                     </div>
                     <table class="calendar">
                        <thead>
                           <tr>
                              <td>Mon</td>
                              <td>Tue</td>
                              <td>Wed</td>
                              <td>Thu</td>
                              <td>Fri</td>
                              <td>Sat</td>
                              <td>Sun</td>
                           </tr>
                        </thead>
                        <tbody>
                           <tr>
                              <td class="prev-month">29</td>
                              <td class="prev-month">30</td>
                              <td class="prev-month">31</td>
                              <td>1</td>
                              <td>2</td>
                              <td>3</td>
                              <td>4</td>
                           </tr>
                           <tr>
                              <td>5</td>
                              <td>6</td>
                              <td>7</td>
                              <td>8</td>
                              <td>9</td>
                              <td>10</td>
                              <td>11</td>
                           </tr>
                           <tr>
                              <td>12</td>
                              <td>13</td>
                              <td>14</td>
                              <td>15</td>
                              <td>16</td>
                              <td>17</td>
                              <td class="current-day">18</td>
                           </tr>
                           <tr>
                              <td>19</td>
                              <td>20</td>
                              <td>21</td>
                              <td>22</td>
                              <td>23</td>
                              <td>24</td>
                              <td>25</td>
                           </tr>
                           <tr>
                              <td>26</td>
                              <td>27</td>
                              <td>28</td>
                              <td>29</td>
                              <td>30</td>
                              <td>31</td>
                              <td class="next-month">1</td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
    """
  end
end
