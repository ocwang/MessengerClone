defmodule MessengerClone.Repo.Migrations.AssociateUsersAndChats do
  use Ecto.Migration

  def change do
    create table(:users_chats, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :chat_id, references(:chats, on_delete: :delete_all)
    end
  end
end
