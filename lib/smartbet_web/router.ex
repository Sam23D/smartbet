defmodule SmartbetWeb.Router do
  use SmartbetWeb, :router
  import Phoenix.LiveView.Router

  import SmartbetWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SmartbetWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/server_dashboard", metrics: SmartbetWeb.Telemetry
    end
  end

  scope "/", SmartbetWeb do
    pipe_through :browser

    get "/", PageController, :index


    scope "/dashboard" do
      get "/", DashboardController, :index
      get "/scores", DashboardController, :scores
    end

  end

  scope "/", SmartbetWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", SmartbetWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    get "/users/settings/edit_password", UserSettingsController, :edit_password
    get "/users/settings/edit_teams", UserSettingsController, :edit_teams
    get "/users/settings/edit_bet+settings", UserSettingsController, :edit_bet
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email


    live "/live_user_bets", UserBetsLive
    live "/live_dashboard", DashboardLive

    scope "/admin" do
      get "/user_bets/delete/:id", UserBetsController, :delete
      resources "/user_bets", UserBetsController, except: [:delete]
      get "/user_bets/:id/:bet_result", UserBetsController, :close_bet

      resources "/countries", CountryController
      resources "/basketball_teams", BasketballTeamController
      resources "/basketball_leagues", BasketballLeageController

      live "/live_console", AdminConsoleLive
      live "/live_console/basketball_league", BasketballLeagueLive
    end

  end

  scope "/", SmartbetWeb do
    pipe_through [:browser]

    get "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
