defmodule MessengerClone.UserView do
  use MessengerClone.Web, :view

  def render("index.json", %{users: users}) do
    render_many(users, MessengerClone.UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, MessengerClone.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      username: user.username}
  end
end
