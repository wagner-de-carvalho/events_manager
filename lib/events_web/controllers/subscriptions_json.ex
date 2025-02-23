defmodule EventsWeb.SubscriptionsJSON do
  @moduledoc """
  Subscription context view
  """
  @default_domain "http://acme.com"

  def create(%{subscription: subscription}) do
    data(subscription)
  end

  def ranking(%{ranking: ranking_list}) do
    ranking_list
    |> Enum.map(&ranking_data/1)
    |> top_3()
  end

  def ranking_by_user(%{position: position}) do
    %{
      ranking_position: position.ranking_position,
      user: %{
        count: position.count,
        name: position.name,
        user_id: position.user_id
      }
    }
  end

  defp data(subscription) do
    designation =
      "#{@default_domain}/#{subscription.event.pretty_name}/#{subscription.subscriber_user_id}"

    %{subscription_number: subscription.id, designation: designation}
  end

  defp top_3(ranking_list), do: Enum.slice(ranking_list, 0..2)

  defp ranking_data(ranking) do
    %{name: ranking.name, quantity: ranking.quantity}
  end
end
