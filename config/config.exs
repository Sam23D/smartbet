# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :smartbet,
  ecto_repos: [Smartbet.Repo]

# Configures the endpoint
config :smartbet, SmartbetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Tk7gUVMb8QgXmHPdwtzf8gxgbjM96nisb1/RPnBHtqDberCUgqzvR9SNTt6tG/XP",
  render_errors: [view: SmartbetWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Smartbet.PubSub,
  live_view: [signing_salt: "ZpFxQJza"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
