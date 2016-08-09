defmodule MessengerClone.Strategies.Authentication do
  import Ecto.Query
  import Comeonin.Bcrypt
  import Plug.Conn, only: [put_session: 3, fetch_session: 1]

  alias MessengerClone.{User}

  def call(conn, module, repo, %{"username" => username, "password" => password}) do
    module
    |> where(username: ^username)
    |> repo.one()
    |> case do
      nil -> {:unauthorized, "record not found"}
      user ->
        cond do
          checkpw(password, user.password_hash) ->
            conn =
              conn
              |> fetch_session()
              |> put_session(:user_id, user.id)
            {:ok, conn, user}
          true -> {:unauthorized, "token check failed"}
        end
    end
  end
end
