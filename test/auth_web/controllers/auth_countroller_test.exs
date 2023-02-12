defmodule AuthWeb.AuthControllerTest do
  use AuthWeb.ConnCase
  alias AuthWeb.UserFactory, as: Factory

  describe "POST /api/register" do
    test "register success", %{conn: conn} do
      conn = post(conn, "/api/register", %{
        "user" => %{
          "name" => "Test User Name",
          "email" => "test@exm.com",
          "password" => "123456"
        }
      })

    assert %{
        "name" => "Test User Name",
        "email" => "test@exm.com",
        "id" => _
      } = json_response(conn, 201)
    end

    test "email is reused", %{conn: conn} do
      {:ok, user} = Factory.insert(:user)
      conn = post(conn, "/api/register", %{
        "user" => %{
          "name" => user.name,
          "email" => user.email,
          "password" => "123456"
        }
      })
      assert %{
        "errors" => [
          %{
            "detail" => "has already been taken",
            "source" => %{"pointer" => "/data/attributes/email"},
            "title" => "Invalid Attribute"
          }
        ]
      } = json_response(conn, 409)
    end

    test "email format error", %{conn: conn} do
      conn = post(conn, "/api/register", %{
        "user" => %{
          "name" => "Test User Name",
          "email" => "hello.com",
          "password" => "123456"
        }
      })
      assert %{
        "errors" => [
          %{
            "detail" => "has invalid format",
            "source" => %{"pointer" => "/data/attributes/email"},
            "title" => "Invalid Attribute"
          }
        ]
      } = json_response(conn, 409)
    end
  end
end
