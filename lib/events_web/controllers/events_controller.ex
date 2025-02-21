defmodule EventsWeb.EventsController do
  @moduledoc """
  Controller for events context
  """
  use EventsWeb, :controller
  alias Events.Event
  alias EventsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, event} <- Events.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, event: event)
    end
  end

  def get(conn, %{"id" => id}) do
    with %Event{} = event <- Events.get(id) do
      conn
      |> put_status(:ok)
      |> render(:show, event: event)
    end
  end

  def get_by_pretty_name(conn, %{"pretty_name" => pretty_name}) do
    with %Event{} = event <- Events.get_by_pretty_name(pretty_name) do
      conn
      |> put_status(:ok)
      |> render(:show, event: event)
    end
  end

  def list(conn, _params) do
    with events <- Events.list() do
      conn
      |> put_status(:ok)
      |> render(:list, events: events)
    end
  end
end
