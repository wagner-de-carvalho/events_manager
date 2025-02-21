defmodule Events.Subscriptions.Create do
  @moduledoc """
  Create new subscription
  """
  alias Events.Repo
  alias Events.Subscriptions.Subscription

  def call(params) do
    params
    |> Subscription.changeset()
    |> Repo.insert()
  end
end
