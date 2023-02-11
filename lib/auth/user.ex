defmodule Auth.User do
  @moduledoc """
  The User Model.
  """

  import Ecto.Query, warn: false
  alias Auth.Repo

  alias Auth.Schemas.User

  def get_user_by_email(email) when is_binary(email), do: Repo.get_by(User, email: email)

  def get_user_by_id(id) when is_binary(id), do: Repo.get_by(User, id: id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def verify_user(%{"email" => email, "password" => password}) do
    get_user_by_email(email)
    |> User.verify_password(password)
  end
end
