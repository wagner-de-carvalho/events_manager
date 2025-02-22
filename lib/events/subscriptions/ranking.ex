defmodule Events.Subscriptions.Ranking do
  @moduledoc """
  Generate ranking of event indications
  """
  import Ecto.Query
  alias Events.Repo
  alias Events.Subscriptions.Subscription

  def call(pretty_name) do
    pretty_name
    |> Events.get_by_pretty_name()
    |> then(fn
      nil -> {:error, "event not found"}
      event -> ranking(event.id)
    end)
  end

  defp ranking(event_id) do
    Subscription
    |> join(:inner, [s], assoc(s, :indication), as: :referrer)
    |> where([s], not is_nil(s.indication_user_id) and s.event_id == ^event_id)
    |> select([s, referrer], %{
      indication_user_id: s.indication_user_id,
      quantity: count(s.id),
      name: referrer.name
    })
    |> group_by([s, referrer], [s.indication_user_id, referrer.name])
    |> order_by([s], desc: count(s.id))
    |> Repo.all()
  end
end
