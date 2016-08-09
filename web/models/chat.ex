defmodule MessengerClone.Chat do
  use MessengerClone.Web, :model

  schema "chats" do
    field :name, :string
    # many_to_many :users, MessengerClone.User, join_through: "chats_users"

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
