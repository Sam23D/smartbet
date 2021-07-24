defmodule Smartbet.Repo do
  use Ecto.Repo,
    otp_app: :smartbet,
    adapter: Ecto.Adapters.Postgres
end
