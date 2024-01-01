defmodule Forii.Repo.Migrations.V2 do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :login_code, :integer
    end
  end
end
