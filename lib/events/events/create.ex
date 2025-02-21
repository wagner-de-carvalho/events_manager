defmodule Events.Create do
  @moduledoc """
  Create a new event
  """
  alias Events.Event
  alias Events.Repo

  def call(%{title: title} = params) do
    pretty_name = Events.generate_pretty_name(title)

    params
    |> Map.put(:pretty_name, pretty_name)
    |> Event.changeset()
    |> Repo.insert()
  end
end
