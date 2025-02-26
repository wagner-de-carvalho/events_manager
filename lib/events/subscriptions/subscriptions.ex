defmodule Events.Subscriptions do
  @moduledoc """
  Subscriptions context
  """
  alias Events.Subscriptions.Create
  alias Events.Subscriptions.Ranking
  alias Events.Subscriptions.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate ranking(pretty_name), to: Ranking, as: :call
  defdelegate get(id), to: Get, as: :call

  def ranking_position(ranking, user_id) do
    user_id = String.to_integer(user_id)

    ranking
    |> Enum.find_index(fn %{indication_user_id: id} -> id == user_id end)
    |> then(fn
      nil ->
        {:error, "user #{user_id} not in the ranking"}

      position ->
        user =
          Enum.find(ranking, fn %{indication_user_id: id} -> id == user_id end)

        %{ranking_position: position + 1, user_id: user_id, name: user.name, count: user.quantity}
    end)
  end
end
