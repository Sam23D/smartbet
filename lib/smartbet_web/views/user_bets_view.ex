defmodule SmartbetWeb.UserBetsView do
  use SmartbetWeb, :view

  def pretty_print_date(date) do
    date
    |> Timex.format!("{D}/{M}/{YYYY}")
  end

  def result_class(result) do

    case result do
       "Pending" ->
        "is-warning is-rounded tag"

        "Win" ->
          "is-success is-rounded tag"

        "Lost" ->
          "is-danger is-rounded tag"

          _ ->
            "is-danger is-rounded tag"

    end

  end

end
