defmodule Events.Subscriptions.GenerateRanking do
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
      event -> get_rankings(event.id)
    end)
  end

  defp get_rankings(event_id) do
    Subscription
    |> join(:inner, [s], assoc(s, :subscriber), as: :users)
    |> where([s], not is_nil(s.indication_user_id) and s.event_id == ^event_id)
    |> select([s, users], %{
      indication_user_id: s.indication_user_id,
      quantity: count(s.id)
    })
    |> group_by([s], [s.indication_user_id])
    |> order_by([s], desc: count(s.id))
    |> Repo.all()
  end
end
