
defmodule SmartbetWeb.UserBetsView do
  use SmartbetWeb, :view
  alias SmartbetWeb.Components.Huro
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

  def profit_color(net_profit) do
    case Decimal.compare(net_profit,0) do
      :lt ->  "is-red h-icon  is-rounded"
      :gt ->  "is-green h-icon  is-rounded"
      :eq ->  "is-info h-icon  is-rounded"
    end
  end

end
