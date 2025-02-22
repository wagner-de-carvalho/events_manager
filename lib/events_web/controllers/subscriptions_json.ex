defmodule EventsWeb.SubscriptionsJSON do
  @moduledoc """
  Subscription context view
  """
  @default_domain "http://acme.com"

  def create(%{subscription: subscription}) do
    data(subscription)
  end

  defp data(subscription) do
    designation =
      "#{@default_domain}/#{subscription.event.pretty_name}/#{subscription.subscriber_user_id}"

    %{subscription_number: subscription.id, designation: designation}
  end
end
