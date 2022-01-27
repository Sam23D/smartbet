defmodule Smartbet.MixProject do
  use Mix.Project

  def project do
    [
      app: :smartbet,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      name: "Smartbets",
      source_url: "https://github.com/USER/PROJECT",
      homepage_url: "http://smartbets.app",
      docs: [
        main: "Smartbet",
        logo: "priv/static/images/logos/logo/logo.svg",
        filter_modules: ~r/Smartbet\.[Outbound|Accounts|Sports]?/,
        extras: ["README.md"],
        groups_for_modules: [
          "Interfaces": [Smartbet.Sports],
          "API Adapters": [Smartbet.Outbound.SportsAPIBasketballFetcher],
        ]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Smartbet.Application, []},
      extra_applications: [:logger, :runtime_tools]

    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bcrypt_elixir, "~> 2.0"},
      {:phoenix, "~> 1.6.0-rc.0", override: true},
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.1"},
      {:phoenix_live_view, "~> 0.16.0"},
      {:phoenix_live_session, "~> 0.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.5"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 0.5"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:phx_gen_auth, "~> 0.7", only: [:dev], runtime: false},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev},
      {:timex, "~> 3.0"},
      {:scrivener_ecto, "~> 2.0"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["esbuild default --minify", "phx.digest"]

    ]
  end
end
