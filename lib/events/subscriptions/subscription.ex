defmodule Events.Subscriptions.Subscription do
  @moduledoc """
  Represents a subscription to an event
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Events.Event
  alias Events.Users.User

  @fields ~w(event_id subscriber_user_id indication_user_id)a
  @required @fields -- [:indication_user_id]

  schema "subscriptions" do
    belongs_to :event, Event
    belongs_to :subscriber, User, foreign_key: :subscriber_user_id
    belongs_to :indication, User, foreign_key: :indication_user_id
    timestamps()
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(%__MODULE__{} = subscription, attrs) do
    subscription
    |> cast(attrs, @fields)
    |> validate_required(@required)
    |> assoc_constraint(:subscriber)
    |> assoc_constraint(:indication)
    |> foreign_key_constraint(:indication_user_id, message: "Invalid indication user")
    |> foreign_key_constraint(:subscriber_user_id, message: "Invalid subscriber user")
    |> foreign_key_constraint(:event_id, message: "Invalid event")
    |> unique_constraint([:event_id, :subscriber_user_id],
      name: :unique_subscription_by_user,
      message: "User is already subscribed to this event"
    )
  end
end
