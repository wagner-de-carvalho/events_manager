defmodule Events.Subscriptions.Subscription do
  @moduledoc """
  Represents a subscription to an event
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Events.Event
  alias Events.Users.User

  @fields ~w(event_id subscriber_id indication_id)a
  @required @fields

  schema "subscriptions" do
    belongs_to :event, Event
    belongs_to :subscriber_user, User, foreign_key: :subscriber_user_id
    belongs_to :indication_user, User, foreign_key: :indication_user_id
  end

  def changeset(%__MODULE__{} = subscription, attrs) do
    subscription
    |> cast(attrs, @fields)
    |> validate_required(@required)
    |> assoc_constraint(:subscriber)
    |> assoc_constraint(:indication)
  end
end
