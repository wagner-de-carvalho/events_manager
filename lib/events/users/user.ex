defmodule Events.Users.User do
  @moduledoc """
  Represents a user
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Events.Subscriptions.Subscription

  @fields ~w(name email)a
  @required @fields

  schema "users" do
    field :name, :string
    field :email, :string

    has_many :subscriptions, Subscription, foreign_key: :subscriber_user_id
    has_many :indications, Subscription, foreign_key: :indication_user_id

    timestamps()
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@required)
    |> validate_length(:name, min: 3, max: 255)
    |> validate_length(:email, max: 255)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
