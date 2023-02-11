defmodule Auth.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Auth.Schemas.User

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :encrypted_password, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :name])
    |> validate_required([:email, :name, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> encrypt_password()
  end

  def verify_password(%User{encrypted_password: encrypted_password} = user, password) do
    case Bcrypt.verify_pass(password, encrypted_password) do
      true -> {:ok, user}
      false -> {:error, "verify error"}
    end
  end

  def verify_password(_, _) do
    {:error, "verify error"}
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)
    if password && changeset.valid? do
      changeset
      |> put_change(:encrypted_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end
end
