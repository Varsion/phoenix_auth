defmodule AuthWeb.UserFactory do
  alias Auth.User

  def build(:user) do
    %{
      "email" => "test_factory@exm.com",
      "name" => "test_factory_user",
      "password" => "123456"
    }
  end

  def build(factory_name) do
    factory_name |> build()
  end

  def insert(factory_name) do
    factory_name
    |> build()
    |> User.create_user()
  end
end
