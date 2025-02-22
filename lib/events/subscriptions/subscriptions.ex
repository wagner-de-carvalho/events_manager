defmodule Events.Subscriptions do
  @moduledoc """
  Subscriptions context
  """
  alias Events.Subscriptions.Create
  alias Events.Subscriptions.Ranking
  alias Events.Subscriptions.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate ranking(pretty_name), to: Ranking, as: :call
  defdelegate get(id), to: Get, as: :call
end
