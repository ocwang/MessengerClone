defmodule MessengerClone.SessionController do
  use MessengerClone.Web, :controller

  alias MessengerClone.{Repo, User, UserView, Strategies.Authentication}

  def create(conn, credentials) do
    Authentication.call(conn, User, Repo, credentials)
    |> case do
      {:ok, conn, user} ->
        conn
        |> put_status(200)
        |> render(UserView, "show.json", user: user)
      {:unauthorized, _message} -> send_resp(conn, 401, "")
    end
  end

  # def delete(conn, _params) do
  #   conn
  #   |> Plug.Conn.delete_session(:account_id)
  #   |> Plug.Conn.delete_session(:account_type)
  #   |> Map.put(:assigns, Map.delete(conn.assigns, :account))
  #   |> send_resp(204, "")
  # end
end
