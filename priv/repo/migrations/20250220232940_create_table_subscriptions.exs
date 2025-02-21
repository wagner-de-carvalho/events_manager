defmodule Events.Repo.Migrations.CreateTableSubscriptions do
  use Ecto.Migration

  def change do
    create table("subscriptions") do
      add :event_id, references("events")
      add :subscriber_user_id, references("users")
      add :indication_user_id, references("users")
      timestamps()
    end
  end
end
