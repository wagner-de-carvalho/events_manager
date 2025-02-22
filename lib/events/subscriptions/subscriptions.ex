defmodule Events.Subscriptions do
  @moduledoc """
  Subscriptions context
  """
  alias Events.Subscriptions.Create
  alias Events.Subscriptions.GenerateRanking
  alias Events.Subscriptions.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate generate_ranking(pretty_name), to: GenerateRanking, as: :call
  defdelegate get(id), to: Get, as: :call
end
