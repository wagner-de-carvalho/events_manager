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

  def ranking_by_user(%{ranking: ranking_list, user_id: user_id}) do
    ranking_by_user_data(ranking_list, user_id)
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

  defp ranking_by_user_data(ranking, user_id) do
    user_id = String.to_integer(user_id)

    position =
      Enum.find_index(ranking, fn %{indication_user_id: id} ->
        id == user_id
      end)

    case position do
      nil ->
        %{error: "user #{user_id} not in the ranking"}

      _ ->
        user =
          Enum.find(ranking, fn %{indication_user_id: id} ->
            id == user_id
          end)

        %{
          ranking_position: position + 1,
          user: %{user_id: user_id, name: user.name, count: user.quantity}
        }
    end
  end
end
