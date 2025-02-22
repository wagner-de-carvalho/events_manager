defmodule Events.Users do
  @moduledoc """
  Users context
  """
  alias Events.Users.Create
  alias Events.Users.Get
  alias Events.Users.GetByEmail

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate get_by_email(email), to: GetByEmail, as: :call
end
