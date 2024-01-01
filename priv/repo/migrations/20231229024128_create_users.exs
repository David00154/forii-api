defmodule Forii.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false
      add :user_role, :integer

      add :last_signin_at, :utc_datetime
      add :current_signin_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email, :username])
  end
end
