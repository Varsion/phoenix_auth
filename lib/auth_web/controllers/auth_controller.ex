defmodule AuthWeb.AuthController do
  use AuthWeb, :controller

  alias Auth.User
  alias Auth.Token

  def login(conn, user_params) do
    with {:ok, user} <- User.verify_user(user_params),
         {:ok, token} <- Token.sign(%{user_id: user.id}) do
          json(conn, %{
            token: token
          })
    else
      _ ->
        json(conn, %{
          error: "email or password is in correct"
        })
    end
  end

  def register(conn, %{"user" => user_params}) do
    case User.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("auth.json", user: user)
      {:error, errors} ->
        conn
        |> put_status(:conflict)
        |> put_view(AuthWeb.ChangesetView)
        |> render("error.json", changeset: errors)
    end
  end
end
