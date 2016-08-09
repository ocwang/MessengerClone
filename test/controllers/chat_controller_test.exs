defmodule MessengerClone.ChatControllerTest do
  use MessengerClone.ConnCase

  alias MessengerClone.Chat
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, chat_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    chat = Repo.insert! %Chat{}
    conn = get conn, chat_path(conn, :show, chat)
    assert json_response(conn, 200)["data"] == %{"id" => chat.id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, chat_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, chat_path(conn, :create), chat: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Chat, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, chat_path(conn, :create), chat: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    chat = Repo.insert! %Chat{}
    conn = put conn, chat_path(conn, :update, chat), chat: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Chat, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    chat = Repo.insert! %Chat{}
    conn = put conn, chat_path(conn, :update, chat), chat: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    chat = Repo.insert! %Chat{}
    conn = delete conn, chat_path(conn, :delete, chat)
    assert response(conn, 204)
    refute Repo.get(Chat, chat.id)
  end
end
