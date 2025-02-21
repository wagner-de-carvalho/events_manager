defmodule Events.Events.GetByPrettyName do
  @moduledoc """
  Get an event by pretty_name
  """
  alias Events.Repo
  alias Events.Event

  def call(pretty_name), do: Repo.get_by(Event, pretty_name: pretty_name)
end
