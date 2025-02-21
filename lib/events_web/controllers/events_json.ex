defmodule EventsWeb.EventsJSON do
  @moduledoc """
  Events context view
  """

  def create(%{event: event}) do
    data(event)
  end

  def list(%{events: events}) do
    Enum.map(events, &data/1)
  end

  def show(%{event: event}) do
    data(event)
  end

  defp data(event) do
    %{
      id: event.id,
      title: event.title,
      pretty_name: event.pretty_name,
      location: event.location,
      price: event.price,
      start_date: event.start_date,
      end_date: event.end_date,
      start_time: event.start_time,
      end_time: event.end_time
    }
  end
end
