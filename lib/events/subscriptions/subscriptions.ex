defmodule Events.Subscriptions do
  @moduledoc """
  Subscriptions context
  """
  alias Events.Subscriptions.Create
  alias Events.Subscriptions.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
