defmodule Events.Users.Create do
  @moduledoc """
  Create a new user
  """
  alias Events.Repo
  alias Events.Users.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
