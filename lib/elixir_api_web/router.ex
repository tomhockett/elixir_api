defmodule ElixirApiWeb.Router do
  use ElixirApiWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  def handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  def handle_errors(conn, _reason) do
    conn |> json(%{errors: "Internal Server Error"}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug ElixirApiWeb.Auth.Pipeline
    plug ElixirApiWeb.Auth.SetAccount
  end

  scope "/api", ElixirApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    options "/", DefaultController, :nothing
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
  end

  scope "/api", ElixirApiWeb do
    pipe_through [:api, :auth]
    get "/accounts/by_id/:id", AccountController, :show
    get "/accounts/sign_out", AccountController, :sign_out
    post "/accounts/update", AccountController, :update
  end
end
