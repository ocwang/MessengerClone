defmodule MessengerClone.UserController do
  use MessengerClone.Web, :controller
  alias MessengerClone.Repo
  alias MessengerClone.User

  def index(conn, _params) do
      users = Repo.all(User)
      render conn, "index.json", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  def create(conn, _params) do
    changeset = User.registration_changeset(%User{}, conn.body_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(201)
        |> render("show.json", user: user)
      {:error, changeset} ->
        send_resp(conn, 422, "")
    end
  end
end
