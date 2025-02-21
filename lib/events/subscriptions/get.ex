defmodule Events.Subscriptions.Get do
  @moduledoc """
  Get a subscription
  """
  alias Events.Repo
  alias Events.Subscriptions.Subscription

  def call(id) do
    Subscription
    |> Repo.get(id)
    |> then(fn
      nil -> {:error, "subscription not found"}
      %Subscription{} = subscription -> subscription
    end)
  end
end
