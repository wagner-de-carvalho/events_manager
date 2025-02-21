defmodule Events.Event do
  @moduledoc """
  Represents an event
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Events.Subscriptions.Subscription

  @fields ~w(title pretty_name location price start_date end_date start_time end_time)a
  @required ~w(title pretty_name location price)a

  schema "events" do
    field :title, :string
    field :pretty_name, :string
    field :location, :string
    field :price, :decimal, default: 0.0
    field :start_date, :date
    field :end_date, :date
    field :start_time, :time
    field :end_time, :time

    has_many :subscriptions, Subscription
    has_many :subscribers, through: [:subscriptions, :subscriber_user]

    timestamps()
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(%__MODULE__{} = event, attrs) do
    event
    |> cast(attrs, @fields)
    |> validate_required(@required)
    |> validate_length(:title, min: 3, max: 255)
    |> validate_length(:pretty_name, min: 3, max: 50)
    |> validate_length(:location, min: 3, max: 255)
    |> validate_number(:price, greater_than_or_equal_to: 0)
    |> unique_constraint(:pretty_name)
  end
end
