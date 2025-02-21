defmodule Events.Users do
  @moduledoc """
  Users context
  """
  alias Events.Users.Get
  alias Events.Users.GetByEmail

  defdelegate get(id), to: Get, as: :call
  defdelegate get_by_email(email), to: GetByEmail, as: :call
end
