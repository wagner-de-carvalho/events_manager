defmodule Events.Events.List do
  @moduledoc """
  List all events
  """
  alias Events.Repo
  alias Events.Event

  def call, do: Repo.all(Event)
end
