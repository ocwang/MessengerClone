defmodule MessengerClone.PageController do
  use MessengerClone.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
