defmodule MessengerClone.Router do
  use MessengerClone.Web, :router
  alias MessengerClone.Strategies.APIVersion

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :v1 do
    plug APIVersion, version: :v1
  end

  scope "/", MessengerClone do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", MessengerClone do
    pipe_through [:api, :v1]

    resources "/chats", ChatController
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
    resources "/users", UserController, only: [:index, :show, :create] do
      get "/friends", UserController, :friends
    end
  end
end
