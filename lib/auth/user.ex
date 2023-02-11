defmodule Auth.User do
  @moduledoc """
  The User Model.
  """

  import Ecto.Query, warn: false
  alias Auth.Repo

  alias Auth.Schemas.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
end
