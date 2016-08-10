# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MessengerClone.Repo.insert!(%MessengerClone.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias MessengerClone.Chat
alias MessengerClone.User
alias MessengerClone.Repo
alias Ecto.Changeset

# %Chat{name: "test three"}
# |> Repo.insert!

chat_one =
  Repo.get_by(Chat, name: "test")
  |> Repo.preload(:users)

chat_two =
  Repo.get_by(Chat, name: "test two")
  |> Repo.preload(:users)

chat_three =
  Repo.get_by(Chat, name: "test three")
  |> Repo.preload(:users)

user =
  Repo.get_by(User, username: "testuser")
  |> Repo.preload([:chats])

chat_changesets = Enum.map([chat_one, chat_two, chat_three], &Changeset.change/1)

user
|> Changeset.change
|> Changeset.put_assoc(:chats, chat_changesets)
|> Repo.update!

# ** (Postgrex.Error) ERROR (unique_violation): duplicate key value violates unique constraint "users_chats_user_id_index"
#
#     table: users_chats
#     constraint: users_chats_user_id_index
