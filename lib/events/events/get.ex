defmodule Events.Get do
  @moduledoc """
  Get an event
  """
  alias Events.Event
  alias Events.Repo

  def call(id) do
    IO.inspect(id, label: "ID >>>>>>>> ")

    Event
    |> Repo.get(id)
    |> then(fn
      nil -> {:error, "event not found"}
      %Event{} = event -> event
    end)
  end
end
