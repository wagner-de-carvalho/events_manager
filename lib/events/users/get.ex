defmodule Events.Users.Get do
  @moduledoc """
  Get an user
  """
  alias Events.Repo
  alias Events.Users.User

  def call(id) do
    User
    |> Repo.get(id)
    |> then(fn
      nil -> {:error, "user not found"}
      %User{} = user -> user
    end)
  end
end
