defmodule Forii.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string
    field :login_code, :integer
    field :last_signin_at, :utc_datetime
    field :current_signin_at, :utc_datetime
    field :user_role, Ecto.Enum, values: [administrator: 1, moderator: 2, user: 3, shadow_user: 4]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :username,
      :email,
      :password,
      :last_signin_at,
      :current_signin_at,
      :user_role,
      :login_code
    ])
    |> validate_required([:username, :email, :password, :user_role])
    |> validate_format(:email, ~r/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
      message: "Invalid email address. Please enter a valid email in the format user@example.com.
    "
    )
    |> validate_length(:email, max: 160)
    |> unique_constraint([:email, :username])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changes), do: changes
end
