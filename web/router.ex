defmodule MessengerClone.Router do
  use MessengerClone.Web, :router
  alias MessengerClone.Strategies.APIVersioning

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  pipeline :v1 do
    plug APIVersioning, version: :v1
  end

  scope "/", MessengerClone do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", MessengerClone do
    pipe_through :api

    scope "/v1" do
      pipe_through :v1

      resources "/users", UserController, only: [:index, :show, :create]
    end
  end
end
