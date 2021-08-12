defmodule SmartbetWeb.DashboardView do
    use SmartbetWeb, :view

    def class_is_active_for_view?(conn, view_name) when is_binary(view_name) do
        if String.contains?(conn.request_path, view_name)do
            "is-active"
        else
            ""
        end
    end
end
