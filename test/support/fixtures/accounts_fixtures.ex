defmodule Forii.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Forii.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{

      })
      |> Forii.Accounts.create_user()

    user
  end
end
