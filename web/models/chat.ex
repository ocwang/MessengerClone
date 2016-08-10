defmodule MessengerClone.Chat do
  use MessengerClone.Web, :model

  schema "chats" do
    field :name, :string

    many_to_many :users, MessengerClone.User, join_through: "users_chats"

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [])
    |> validate_required([])
  end
end
