defmodule Events.Repo.Migrations.CreateTableEvent do
  use Ecto.Migration

  def change do
    create table("events") do
      add :title, :string, size: 255, null: false
      add :pretty_name, :string, size: 50, null: false
      add :location, :string, size: 255, null: false
      add :price, :decimal, null: false, default: 0.0
      add :start_date, :date
      add :end_date, :date
      add :start_time, :time
      add :end_time, :time
      timestamps()
    end

    create unique_index("events", [:pretty_name])
  end
end
