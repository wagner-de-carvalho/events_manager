defmodule EventsWeb.SubscriptionsController do
  @moduledoc """
  Controller for subscription context
  """
  use EventsWeb, :controller
  alias EventsWeb.FallbackController
  alias Events.Repo
  alias Events.Subscriptions

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, subscription} <- Subscriptions.create(params) do
      subscription = Repo.preload(subscription, [:event])

      conn
      |> put_status(:created)
      |> render(:create, subscription: subscription)
    end
  end
end
