defmodule Events.Repo.Migrations.CreateTableUser do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string, size: 255, null: false
      add :email, :string, size: 255, null: false
      timestamps()
    end

    create unique_index("users", [:email])
  end
end
