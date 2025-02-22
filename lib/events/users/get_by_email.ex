defmodule Events.Users.GetByEmail do
  @moduledoc """
  Get a user by email
  """
  alias Events.Repo
  alias Events.Users.User

  def call(email) do
    User
    |> Repo.get_by(email: email)
    |> then(fn
      nil -> {:error, "user not found"}
      %User{} = user -> user
    end)
  end
end
