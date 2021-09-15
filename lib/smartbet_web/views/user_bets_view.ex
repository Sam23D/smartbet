defmodule SmartbetWeb.UserBetsView do
  use SmartbetWeb, :view

  def pretty_print_date(date) do
    date
    |> Timex.format!("{D}/{M}/{YYYY}")
  end
end
