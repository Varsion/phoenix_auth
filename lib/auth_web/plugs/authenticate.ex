defmodule AuthWeb.Plug.Authenticate do
  import Plug.Conn
  alias Auth.User

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Auth.Token.verify(token) do
      conn
      |> assign(:current_user, User.get_user_by_id(data.user_id))
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(AuthWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
    end
  end
end
