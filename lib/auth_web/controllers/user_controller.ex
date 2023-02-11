defmodule AuthWeb.UserController do
  use AuthWeb, :controller

  def index(conn, _) do
    user = conn.assigns[:current_user]
    render(conn, "user.json", user: user)
  end
end
