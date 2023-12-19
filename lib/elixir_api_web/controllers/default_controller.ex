defmodule ElixirApiWeb.DefaultController do
  use ElixirApiWeb, :controller

  def index(conn, _params) do
    # render(conn, "index.html")
    text(conn, "Hello World - #{Mix.env()}")
  end
end
