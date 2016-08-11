require IEx
defmodule MessengerClone.UserController do
  use MessengerClone.Web, :controller
  alias MessengerClone.{Repo, User}

  def index(conn, _params) do
      users = Repo.all(User)
      render conn, "index.json", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  def friends(conn, %{"user_id" => user_id}) do
    users = Repo.all(from u in User, where: u.id != ^user_id)
    render conn, "index.json", users: users
  end

  def chats(conn, %{"user_id" => user_id}) do
    user =
      User
      |> Repo.get_by(id: user_id)
      |> Repo.preload(:chats)

    %{"chats": chats} = user
    render(conn, MessengerClone.ChatView, "index.json", chats: chats)
  end

  # Repo.get_by(Chat, name: "test three")
  # |> Repo.preload(:users)

  def create(conn, params) do
    changeset = User.registration_changeset(%User{}, params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(201)
        |> render("show.json", user: user)
      {:error, _changeset} ->
        send_resp(conn, 422, "")
    end
  end
end
