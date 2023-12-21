defmodule ElixirApiWeb.Router do
  use ElixirApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    options "/", DefaultController, :nothing
    post "/accounts/create", AccountController, :create
  end
end
