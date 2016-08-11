defmodule MessengerClone.ChatView do
  use MessengerClone.Web, :view

  def render("index.json", %{chats: chats}) do
    %{chats: render_many(chats, MessengerClone.ChatView, "chat.json")}
  end

  def render("show.json", %{chat: chat}) do
    %{data: render_one(chat, MessengerClone.ChatView, "chat.json")}
  end

  def render("chat.json", %{chat: chat}) do
    %{id: chat.id, name: chat.name}
  end
end
