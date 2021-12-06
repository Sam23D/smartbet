defmodule SmartbetWeb.DashboardView do
    use SmartbetWeb, :view

    alias SmartbetWeb.Components.Huro
    alias Phoenix.LiveView.Socket
    alias Smartbet.Accounts
    alias SmartbetWeb.AdminConsoleLive

    def class_is_active_for_view?(conn, view_name) when is_binary(view_name) do
        if String.contains?(conn.request_path, view_name)do
            "is-active"
        else
            ""
        end
    end

    @doc """
    Returns true or false depending if the given @conn or @socket has a current user with the specified role
    user_has_role(@conn, "admin")
    """
    @spec user_has_role(map(), String.t()) :: boolean()
    def user_has_role(socket_conn, role) do
        case socket_conn do
            socket=%Socket{} ->
                AdminConsoleLive.get_current_user_token(socket)
                |> Accounts.get_user_by_session_token()
                |> SmartbetWeb.UserAuth.has_role?(role)
            conn ->
                SmartbetWeb.UserAuth.has_role?(conn.assigns.current_user, "admin")
        end
    end

end
