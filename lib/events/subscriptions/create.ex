defmodule Events.Subscriptions.Create do
  @moduledoc """
  Create new subscription
  """
  alias Events.Repo
  alias Events.Subscriptions.Subscription
  alias Events.Users
  alias Events.Users.User

  def call(%{"pretty_name" => pretty_name, "email" => email, "name" => name} = params) do
    event = Events.get_by_pretty_name(pretty_name)
    user = get_user(email, name)
    subscribe(event, user, params)
  end

  defp subscribe(event, user, %{"indication_user_id" => indication_user_id}) do
    %{event_id: event.id, subscriber_user_id: user.id, indication_user_id: indication_user_id}
    |> exec()
  end

  defp subscribe(event, user, _) do
    %{event_id: event.id, subscriber_user_id: user.id}
    |> exec()
  end

  defp exec(params) do
    params
    |> Subscription.changeset()
    |> Repo.insert()
  end

  defp get_user(email, name) do
    case Users.get_by_email(email) do
      %User{} = user ->
        user

      _ ->
        %{name: name, email: email}
        |> Users.create()
        |> elem(1)
    end
  end
end
