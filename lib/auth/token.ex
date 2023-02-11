defmodule Auth.Token do
  @moduledoc """
  Token Helper
  """

  @token_salt "auth_demo"
  # valid for one week
  @token_age_secs 7 * 86_400

  def sign(user_id) do
    {
      :ok,
      Phoenix.Token.sign(AuthWeb.Endpoint, @token_salt, user_id)
    }
  end

  def verify(token) do
    case Phoenix.Token.verify(AuthWeb.Endpoint, @token_salt, token,
             max_age: @token_age_secs
           ) do
      {:ok, data} -> {:ok, data}
      _error -> {:error, :unauthenticated}
    end
  end
end
