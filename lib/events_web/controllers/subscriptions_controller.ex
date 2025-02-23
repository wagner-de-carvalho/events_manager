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

  def ranking(conn, %{"pretty_name" => pretty_name}) do
    with ranking when is_list(ranking) <-
           Subscriptions.ranking(pretty_name) do
      conn
      |> put_status(:ok)
      |> render(:ranking, ranking: ranking)
    end
  end

  def ranking_by_user(conn, %{"pretty_name" => pretty_name, "user_id" => user_id}) do
    with ranking when is_list(ranking) <- Subscriptions.ranking(pretty_name),
         position when is_map(position) <-
           Subscriptions.ranking_position(ranking, user_id) do
      conn
      |> put_status(:ok)
      |> render(:ranking_by_user, position: position)
    end
  end
end
