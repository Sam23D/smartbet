defmodule Smartbet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Smartbet.Repo,
      # Start the Telemetry supervisor
      SmartbetWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Smartbet.PubSub},
      # Start the Endpoint (http/https)
      SmartbetWeb.Endpoint
      # Start a worker by calling: Smartbet.Worker.start_link(arg)
      # {Smartbet.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Smartbet.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SmartbetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
